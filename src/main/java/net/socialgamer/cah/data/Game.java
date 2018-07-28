/**
 * Copyright (c) 2012-2018, Andy Janata
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 *   and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 *   conditions and the following disclaimer in the documentation and/or other materials provided
 *   with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.inject.Inject;
import com.google.inject.Provider;

import net.socialgamer.cah.CahModule.AllowBlankCards;
import net.socialgamer.cah.CahModule.GamePermalinkUrlFormat;
import net.socialgamer.cah.CahModule.RoundPermalinkUrlFormat;
import net.socialgamer.cah.CahModule.ShowGamePermalink;
import net.socialgamer.cah.CahModule.ShowRoundPermalink;
import net.socialgamer.cah.CahModule.UniqueId;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.BlackCardData;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.GameInfo;
import net.socialgamer.cah.Constants.GamePlayerInfo;
import net.socialgamer.cah.Constants.GamePlayerStatus;
import net.socialgamer.cah.Constants.GameState;
import net.socialgamer.cah.Constants.LongPollEvent;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.WhiteCardData;
import net.socialgamer.cah.cardcast.CardcastDeck;
import net.socialgamer.cah.cardcast.CardcastService;
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.data.QueuedMessage.MessageType;
import net.socialgamer.cah.metrics.Metrics;
import net.socialgamer.cah.task.SafeTimerTask;


/**
 * Game data and logic class. Games are simple finite state machines, with 3 states that wait for
 * user input, and 3 transient states that it quickly passes through on the way back to a waiting
 * state:
 *
 * ......Lobby.----------->.Dealing.(transient).-------->.Playing
 * .......^........................^.........................|....................
 * .......|.v----.Win.(transient).<+------.Judging.<---------+....................
 * .....Reset.(transient)
 *
 * Lobby is the default state. When the game host sends a start game event, the game moves to the
 * Dealing state, where it deals out cards to every player and automatically moves into the Playing
 * state. After all players have played a card, the game moves to Judging and waits for the judge to
 * pick a card. The game either moves to Win, if a player reached the win goal, or Dealing
 * otherwise. Win moves through Reset to reset the game back to default state. The game also
 * immediately moves through Reset at any point there are fewer than 3 players in the game.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class Game {
  private static final Logger logger = Logger.getLogger(Game.class);

  private final int id;
  /**
   * All players present in the game.
   */
  private final List<Player> players = Collections.synchronizedList(new ArrayList<Player>(10));
  /**
   * Players participating in the current round.
   */
  private final List<Player> roundPlayers = Collections.synchronizedList(new ArrayList<Player>(9));
  private final PlayerPlayedCardsTracker playedCards = new PlayerPlayedCardsTracker();
  private final List<User> spectators = Collections.synchronizedList(new ArrayList<User>(10));
  private final ConnectedUsers connectedUsers;
  private final GameManager gameManager;
  private Player host;
  private final Provider<Session> sessionProvider;
  private BlackDeck blackDeck;
  private BlackCard blackCard;
  private final Object blackCardLock = new Object();
  private WhiteDeck whiteDeck;
  private GameState state;
  private final GameOptions options = new GameOptions();
  private final Set<String> cardcastDeckIds = Collections.synchronizedSet(new HashSet<String>());
  private final Metrics metrics;
  private final Provider<Boolean> showGameLinkProvider;
  private final Provider<String> gamePermalinkFormatProvider;
  private final Provider<Boolean> showRoundLinkProvider;
  private final Provider<String> roundPermalinkFormatProvider;
  private final Provider<Boolean> allowBlankCardsProvider;
  private final long created = System.currentTimeMillis();

  private int judgeIndex = 0;

  /**
   * The minimum number of black cards that must be added to a game for it to be able to start.
   */
  public final static int MINIMUM_BLACK_CARDS = 50;

  /**
   * The minimum number of white cards per player limit slots that must be added to a game for it to
   * be able to start.
   *
   * We need 20 * maxPlayers cards. This allows black cards up to "draw 9" to work correctly.
   */
  public final static int MINIMUM_WHITE_CARDS_PER_PLAYER = 20;

  // All of these delays could be moved to pyx.properties.
  /**
   * Time, in milliseconds, to delay before starting a new round.
   */
  private final static int ROUND_INTERMISSION = 8 * 1000;
  /**
   * Duration, in milliseconds, for the minimum timeout a player has to choose a card to play.
   * Minimum 10 seconds.
   */
  private final static int PLAY_TIMEOUT_BASE = 45 * 1000;
  /**
   * Duration, in milliseconds, for the additional timeout a player has to choose a card to play,
   * for each card that must be played. For example, on a PICK 2 card, two times this amount of
   * time is added to {@code PLAY_TIMEOUT_BASE}.
   */
  private final static int PLAY_TIMEOUT_PER_CARD = 15 * 1000;
  /**
   * Duration, in milliseconds, for the minimum timeout a judge has to choose a winner.
   * Minimum combined of this and 2 * {@code JUDGE_TIMEOUT_PER_CARD} is 10 seconds.
   */
  private final static int JUDGE_TIMEOUT_BASE = 40 * 1000;
  /**
   * Duration, in milliseconds, for the additional timeout a judge has to choose a winning card,
   * for each additional card that was played in the round. For example, on a PICK 2 card with
   * 3 non-judge players, 6 times this value is added to {@code JUDGE_TIMEOUT_BASE}.
   */
  private final static int JUDGE_TIMEOUT_PER_CARD = 7 * 1000;
  private final static int MAX_SKIPS_BEFORE_KICK = 2;
  private final static Set<String> FINITE_PLAYTIMES;
  static
  {
    final Set<String> finitePlaytimes = new TreeSet<String>(Arrays.asList(
        new String[]{"0.25x", "0.5x", "0.75x", "1x", "1.25x", "1.5x", "1.75x", "2x", "2.5x", "3x", "4x", "5x", "10x"}));
    FINITE_PLAYTIMES = Collections.unmodifiableSet(finitePlaytimes);
  }

  /**
   * Lock object to prevent judging during idle judge detection and vice-versa.
   */
  private final Object judgeLock = new Object();

  /**
   * Lock to prevent missing timer updates.
   */
  private final Object roundTimerLock = new Object();
  private volatile ScheduledFuture<?> lastScheduledFuture;
  private final ScheduledThreadPoolExecutor globalTimer;
  private final Provider<CardcastService> cardcastServiceProvider;
  private final Provider<String> uniqueIdProvider;
  private String currentUniqueId;
  /**
   * Sequence number of cards dealt. This allows re-shuffles and re-deals to still be tracked as
   * unique card deals.
   */
  private long dealSeq = 0;

  /**
   * Create a new game.
   *
   * @param id
   *          The game's ID.
   * @param connectedUsers
   *          The user manager, for broadcasting messages.
   * @param gameManager
   *          The game manager, for broadcasting game list refresh notices and destroying this game
   *          when everybody leaves.
   * @param hibernateSession Hibernate session from which to load cards.
   * @param globalTimer The global timer on which to schedule tasks.
   */
  @Inject
  public Game(@GameId final Integer id, final ConnectedUsers connectedUsers,
      final GameManager gameManager, final ScheduledThreadPoolExecutor globalTimer,
      final Provider<Session> sessionProvider,
      final Provider<CardcastService> cardcastServiceProvider,
      @UniqueId final Provider<String> uniqueIdProvider,
      final Metrics metrics, @ShowRoundPermalink final Provider<Boolean> showRoundLinkProvider,
      @RoundPermalinkUrlFormat final Provider<String> roundPermalinkFormatProvider,
      @ShowGamePermalink final Provider<Boolean> showGameLinkProvider,
      @GamePermalinkUrlFormat final Provider<String> gamePermalinkFormatProvider,
      @AllowBlankCards final Provider<Boolean> allowBlankCardsProvider) {
    this.id = id;
    this.connectedUsers = connectedUsers;
    this.gameManager = gameManager;
    this.globalTimer = globalTimer;
    this.sessionProvider = sessionProvider;
    this.cardcastServiceProvider = cardcastServiceProvider;
    this.uniqueIdProvider = uniqueIdProvider;
    this.metrics = metrics;
    this.showRoundLinkProvider = showRoundLinkProvider;
    this.roundPermalinkFormatProvider = roundPermalinkFormatProvider;
    this.showGameLinkProvider = showGameLinkProvider;
    this.gamePermalinkFormatProvider = gamePermalinkFormatProvider;
    this.allowBlankCardsProvider = allowBlankCardsProvider;

    state = GameState.LOBBY;
  }

  /**
   * Adds a permalink to this game to the client request response data, if said permalinks are
   * enabled.
   * @param data A map of data being returned to a client request.
   */
  public void maybeAddPermalinkToData(final Map<ReturnableData, Object> data) {
    if (showGameLinkProvider.get() && null != currentUniqueId) {
      data.put(AjaxResponse.GAME_PERMALINK,
          String.format(gamePermalinkFormatProvider.get(), currentUniqueId));
    }
  }

  /**
   * Add a player to the game.
   *
   * Synchronizes on {@link #players}.
   *
   * @param user
   *          Player to add to this game.
   * @throws TooManyPlayersException
   *           Thrown if this game is at its maximum player capacity.
   * @throws IllegalStateException
   *           Thrown if {@code user} is already in a game.
   */
  public void addPlayer(final User user) throws TooManyPlayersException, IllegalStateException {
    logger.info(String.format("%s joined game %d.", user.toString(), id));
    synchronized (players) {
      if (options.playerLimit >= 3 && players.size() >= options.playerLimit) {
        throw new TooManyPlayersException();
      }
      // this will throw IllegalStateException if the user is already in a game, including this one.
      user.joinGame(this);
      final Player player = new Player(user);
      players.add(player);
      if (host == null) {
        host = player;
      }
    }

    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_JOIN.toString());
    data.put(LongPollResponse.NICKNAME, user.getNickname());
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

    // Don't do this anymore, it was driving up a crazy amount of traffic.
    // gameManager.broadcastGameListRefresh();
  }

  /**
   * Remove a player from the game.
   * <br/>
   * Synchronizes on {@link #players}, {@link #playedCards}, {@link #whiteDeck}, and
   * {@link #roundTimerLock}.
   *
   * @param user
   *          Player to remove from the game.
   * @return True if {@code user} was the last player in the game.
   */
  public boolean removePlayer(final User user) {
    logger.info(String.format("Removing %s from game %d.", user.toString(), id));
    boolean wasJudge = false;
    final Player player = getPlayerForUser(user);

    if (null != player) {
      HashMap<ReturnableData, Object> data;
      // If they played this round, remove card from played card list.
      final List<WhiteCard> cards = playedCards.remove(player);
      if (cards != null && cards.size() > 0) {
        for (final WhiteCard card : cards) {
          whiteDeck.discard(card);
        }
      }
      // If they are to play this round, remove them from that list.
      if (roundPlayers.remove(player)) {
        if (startJudging()) {
          judgingState();
        }
      }
      // If they have a hand, return it to discard pile.
      if (player.getHand().size() > 0) {
        final List<WhiteCard> hand = player.getHand();
        for (final WhiteCard card : hand) {
          whiteDeck.discard(card);
        }
      }
      // If they are judge, return all played cards to hand, and move to next judge.
      if (getJudge() == player && (state == GameState.PLAYING || state == GameState.JUDGING)) {
        data = getEventMap();
        data.put(LongPollResponse.EVENT, LongPollEvent.GAME_JUDGE_LEFT.toString());
        data.put(LongPollResponse.INTERMISSION, ROUND_INTERMISSION);
        broadcastToPlayers(MessageType.GAME_EVENT, data);
        returnCardsToHand();
        // startNextRound will advance it again.
        judgeIndex--;
        // Can't start the next round right here.
        wasJudge = true;
      }
      // If they aren't judge but are earlier in judging order, fix the judge index.
      else if (players.indexOf(player) < judgeIndex) {
        judgeIndex--;
      }

      // we can't actually remove them until down here because we need to deal with the judge
      // index stuff first.
      players.remove(player);
      user.leaveGame(this);

      // do this down here so the person that left doesn't get the notice too
      data = getEventMap();
      data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_LEAVE.toString());
      data.put(LongPollResponse.NICKNAME, user.getNickname());
      broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

      // Don't do this anymore, it was driving up a crazy amount of traffic.
      // gameManager.broadcastGameListRefresh();

      if (host == player) {
        if (players.size() > 0) {
          host = players.get(0);
        } else {
          host = null;
        }
      }
      // this seems terrible
      if (players.size() == 0) {
        gameManager.destroyGame(id);
      }
      if (players.size() < 3 && state != GameState.LOBBY) {
        logger.info(String.format("Resetting game %d due to too few players after someone left.",
            id));
        resetState(true);
      } else if (wasJudge) {
        synchronized (roundTimerLock) {
          final SafeTimerTask task = new SafeTimerTask() {
            @Override
            public void process() {
              startNextRound();
            }
          };
          rescheduleTimer(task, ROUND_INTERMISSION);
        }
      }
      return players.size() == 0;
    }
    return false;
  }

  /**
   * Add a spectator to the game.
   *
   * Synchronizes on {@link #spectators}.
   *
   * @param user
   *          Spectator to add to this game.
   * @throws TooManySpectatorsException
   *           Thrown if this game is at its maximum spectator capacity.
   * @throws IllegalStateException
   *           Thrown if {@code user} is already in a game.
   */
  public void addSpectator(final User user) throws TooManySpectatorsException,
      IllegalStateException {
    logger.info(String.format("%s joined game %d as a spectator.", user.toString(), id));
    synchronized (spectators) {
      if (spectators.size() >= options.spectatorLimit) {
        throw new TooManySpectatorsException();
      }
      // this will throw IllegalStateException if the user is already in a game, including this one.
      user.joinGame(this);
      spectators.add(user);
    }

    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_SPECTATOR_JOIN.toString());
    data.put(LongPollResponse.NICKNAME, user.getNickname());
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

    gameManager.broadcastGameListRefresh();
  }

  /**
   * Remove a spectator from the game.
   * <br/>
   * Synchronizes on {@link #spectator}.
   *
   * @param user
   *          Spectator to remove from the game.
   */
  public void removeSpectator(final User user) {
    logger.info(String.format("Removing spectator %s from game %d.", user.toString(), id));
    synchronized (spectators) {
      if (!spectators.remove(user)) {
        return;
      } // not actually spectating
      user.leaveGame(this);
    }

    // do this down here so the person that left doesn't get the notice too
    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_SPECTATOR_LEAVE.toString());
    data.put(LongPollResponse.NICKNAME, user.getNickname());
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

    // Don't do this anymore, it was driving up a crazy amount of traffic.
    // gameManager.broadcastGameListRefresh();
  }

  /**
   * Return all played cards to their respective player's hand.
   * <br/>
   * Synchronizes on {@link #playedCards}.
   */
  private void returnCardsToHand() {
    synchronized (playedCards) {
      for (final Player p : playedCards.playedPlayers()) {
        p.getHand().addAll(playedCards.getCards(p));
        sendCardsToPlayer(p, playedCards.getCards(p));
      }
      // prevent startNextRound from discarding cards
      playedCards.clear();
    }
  }

  /**
   * Broadcast a message to all players in this game.
   *
   * @param type
   *          Type of message to broadcast. This determines the order the messages are returned by
   *          priority.
   * @param masterData
   *          Message data to broadcast.
   */
  public void broadcastToPlayers(final MessageType type,
      final HashMap<ReturnableData, Object> masterData) {
    connectedUsers.broadcastToList(playersToUsers(), type, masterData);
  }

  /**
   * Sends updated player information about a specific player to all players in the game.
   *
   * @param player
   *          The player whose information has been changed.
   */
  public void notifyPlayerInfoChange(final Player player) {
    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_INFO_CHANGE.toString());
    data.put(LongPollResponse.PLAYER_INFO, getPlayerInfo(player));
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);
  }

  /**
   * Sends updated game information to all players in the game.
   */
  private void notifyGameOptionsChanged() {
    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_OPTIONS_CHANGED.toString());
    data.put(LongPollResponse.GAME_INFO, getInfo(true));
    broadcastToPlayers(MessageType.GAME_EVENT, data);
  }

  /**
   * @return The game's current state.
   */
  public GameState getState() {
    return state;
  }

  /**
   * @return The {@code User} who is the host of this game.
   */
  public User getHost() {
    if (host == null) {
      return null;
    }
    return host.getUser();
  }

  /**
   * @return All {@code User}s in this game.
   */
  public List<User> getUsers() {
    return playersToUsers();
  }

  /**
   * @return This game's ID.
   */
  public int getId() {
    return id;
  }

  public String getPassword() {
    return options.password;
  }

  public void updateGameSettings(final GameOptions newOptions) {
    this.options.update(newOptions);
    notifyGameOptionsChanged();
  }

  public Set<String> getCardcastDeckIds() {
    return cardcastDeckIds;
  }

  /**
   * Get information about this game, without the game's password.
   * <br/>
   * Synchronizes on {@link #players}.
   * @return This game's general information: ID, host, state, player list, etc.
   */
  @Nullable
  public Map<GameInfo, Object> getInfo() {
    return getInfo(false);
  }

  /**
   * Get information about this game.
   * <br/>
   * Synchronizes on {@link #players}.
   * @param includePassword
   *          Include the actual password with the information. This should only be
   *          sent to people in the game.
   * @return This game's general information: ID, host, state, player list, etc.
   */
  @Nullable
  public Map<GameInfo, Object> getInfo(final boolean includePassword) {
    final Map<GameInfo, Object> info = new HashMap<GameInfo, Object>();
    info.put(GameInfo.ID, id);
    // This is probably happening because the game ceases to exist in the middle of getting the
    // game list. Just return nothing.
    if (null == host) {
      return null;
    }
    info.put(GameInfo.CREATED, created);
    info.put(GameInfo.HOST, host.getUser().getNickname());
    info.put(GameInfo.STATE, state.toString());
    info.put(GameInfo.GAME_OPTIONS, options.serialize(includePassword));
    info.put(GameInfo.HAS_PASSWORD, options.password != null && !options.password.equals(""));

    final Player[] playersCopy = players.toArray(new Player[players.size()]);
    final List<String> playerNames = new ArrayList<String>(playersCopy.length);
    for (final Player player : playersCopy) {
      playerNames.add(player.getUser().getNickname());
    }
    info.put(GameInfo.PLAYERS, playerNames);

    final User[] spectatorsCopy = spectators.toArray(new User[spectators.size()]);
    final List<String> spectatorNames = new ArrayList<String>(spectatorsCopy.length);
    for (final User spectator : spectatorsCopy) {
      spectatorNames.add(spectator.getNickname());
    }
    info.put(GameInfo.SPECTATORS, spectatorNames);

    return info;
  }

  /**
   * Synchronizes on {@link #players}.
   * @return Player information for every player in this game: Name, score, status.
   */
  public List<Map<GamePlayerInfo, Object>> getAllPlayerInfo() {
    final List<Map<GamePlayerInfo, Object>> info;
    final Player[] playersCopy = players.toArray(new Player[players.size()]);
    info = new ArrayList<Map<GamePlayerInfo, Object>>(playersCopy.length);
    for (final Player player : playersCopy) {
      final Map<GamePlayerInfo, Object> playerInfo = getPlayerInfo(player);
      info.add(playerInfo);
    }
    return info;
  }

  public final List<Player> getPlayers() {
    final List<Player> copy = new ArrayList<Player>(players.size());
    copy.addAll(players);
    return copy;
  }

  /**
   * Get player information for a single player.
   *
   * @param player
   *          The player for whom to get status.
   * @return Information for {@code player}: Name, score, status.
   */
  public Map<GamePlayerInfo, Object> getPlayerInfo(final Player player) {
    final Map<GamePlayerInfo, Object> playerInfo = new HashMap<GamePlayerInfo, Object>();
    // TODO make sure this can't happen in the first place
    if (player == null) {
      return playerInfo;
    }
    playerInfo.put(GamePlayerInfo.NAME, player.getUser().getNickname());
    playerInfo.put(GamePlayerInfo.SCORE, player.getScore());
    playerInfo.put(GamePlayerInfo.STATUS, getPlayerStatus(player).toString());

    return playerInfo;
  }

  /**
   * Determine the player status for a given player, based on game state.
   *
   * @param player
   *          Player for whom to get the state.
   * @return The state of {@code player}, one of {@code HOST}, {@code IDLE}, {@code JUDGE},
   *         {@code PLAYING}, {@code JUDGING}, or {@code WINNER}, depending on the game's state and
   *         what the player has done.
   */
  private GamePlayerStatus getPlayerStatus(final Player player) {
    final GamePlayerStatus playerStatus;

    switch (state) {
      case LOBBY:
        if (host == player) {
          playerStatus = GamePlayerStatus.HOST;
        } else {
          playerStatus = GamePlayerStatus.IDLE;
        }
        break;
      case PLAYING:
        if (getJudge() == player) {
          playerStatus = GamePlayerStatus.JUDGE;
        } else {
          if (!roundPlayers.contains(player)) {
            playerStatus = GamePlayerStatus.IDLE;
            break;
          }
          final List<WhiteCard> playerCards = playedCards.getCards(player);
          if (playerCards != null && blackCard != null
              && playerCards.size() == blackCard.getPick()) {
            playerStatus = GamePlayerStatus.IDLE;
          } else {
            playerStatus = GamePlayerStatus.PLAYING;
          }
        }
        break;
      case JUDGING:
        if (getJudge() == player) {
          playerStatus = GamePlayerStatus.JUDGING;
        } else {
          playerStatus = GamePlayerStatus.IDLE;
        }
        break;
      case ROUND_OVER:
        if (getJudge() == player) {
          playerStatus = GamePlayerStatus.JUDGE;
        }
        // TODO win-by-x
        else if (player.getScore() >= options.scoreGoal) {
          playerStatus = GamePlayerStatus.WINNER;
        } else {
          playerStatus = GamePlayerStatus.IDLE;
        }
        break;
      default:
        throw new IllegalStateException("Unknown GameState " + state.toString());
    }
    return playerStatus;
  }

  /**
   * Start the game, if there are at least 3 players present. This does not do any access checking!
   * <br/>
   * Synchronizes on {@link #players}.
   *
   * @return True if the game is started. Would only be false if there aren't enough players, or the
   *         game is already started, or doesn't have enough cards, but hopefully callers and
   *         clients would prevent that from happening!
   */
  public boolean start() {
    Session session = null;
    try {
      session = sessionProvider.get();
      if (state != GameState.LOBBY || !hasEnoughCards(session)) {
        return false;
      }
      boolean started;
      final int numPlayers = players.size();
      if (numPlayers >= 3) {
        // Pick a random start judge, though the "next" judge will actually go first.
        judgeIndex = (int) (Math.random() * numPlayers);
        started = true;
      } else {
        started = false;
      }
      if (started) {
        currentUniqueId = uniqueIdProvider.get();
        logger.info(String.format("Starting game %d with card sets %s, Cardcast %s, %d blanks, %d "
            + "max players, %d max spectators, %d score limit, players %s, unique %s.",
            id, options.cardSetIds, cardcastDeckIds, options.blanksInDeck, options.playerLimit,
            options.spectatorLimit, options.scoreGoal, players, currentUniqueId));
        // do this stuff outside the players lock; they will lock players again later for much less
        // time, and not at the same time as trying to lock users, which has caused deadlocks
        final List<CardSet> cardSets;
        synchronized (options.cardSetIds) {
          cardSets = loadCardSets(session);
          blackDeck = loadBlackDeck(cardSets);
          whiteDeck = loadWhiteDeck(cardSets);
        }
        metrics.gameStart(currentUniqueId, cardSets, options.blanksInDeck, options.playerLimit,
            options.scoreGoal, !StringUtils.isBlank(options.password));
        startNextRound();
        gameManager.broadcastGameListRefresh();
      }
      return started;
    } finally {
      if (null != session) {
        session.close();
      }
    }
  }

  public List<CardSet> loadCardSets(final Session session) {
    synchronized (options.cardSetIds) {
      try {
        final List<CardSet> cardSets = new ArrayList<>();

        if (!options.getPyxCardSetIds().isEmpty()) {
          @SuppressWarnings("unchecked")
          final List<CardSet> pyxCardSets = session
              .createQuery("from PyxCardSet where id in (:ids)")
              .setParameterList("ids", options.getPyxCardSetIds()).list();
          cardSets.addAll(pyxCardSets);
        }

        // Not injecting the service itself because we might need to assisted inject it later
        // with card id stuff.
        // also TODO maybe make card ids longs instead of ints
        final CardcastService service = cardcastServiceProvider.get();

        // Avoid ConcurrentModificationException
        for (final String cardcastId : cardcastDeckIds.toArray(new String[0])) {
          // Ideally, we can assume that anything in that set is going to load, but it is entirely
          // possible that the cache has expired and we can't re-load it for some reason, so
          // let's be safe.
          final CardcastDeck cardcastDeck = service.loadSet(cardcastId);
          if (null == cardcastDeck) {
            // TODO better way to indicate this to the user
            logger.error(String.format("Unable to load %s from Cardcast", cardcastId));
            return null;
          }
          cardSets.add(cardcastDeck);
        }

        return cardSets;
      } catch (final Exception e) {
        logger.error(String.format("Unable to load cards for game %d", id), e);
        return null;
      }
    }
  }

  public BlackDeck loadBlackDeck(final List<CardSet> cardSets) {
    return new BlackDeck(cardSets);
  }

  public WhiteDeck loadWhiteDeck(final List<CardSet> cardSets) {
    return new WhiteDeck(cardSets, allowBlankCardsProvider.get() ? options.blanksInDeck : 0);
  }

  public int getRequiredWhiteCardCount() {
    return MINIMUM_WHITE_CARDS_PER_PLAYER * options.playerLimit;
  }

  /**
   * Determine if there are sufficient cards in the selected card sets to start the game.
   */
  public boolean hasEnoughCards(final Session session) {
    synchronized (options.cardSetIds) {
      final List<CardSet> cardSets = loadCardSets(session);

      if (cardSets.isEmpty()) {
        return false;
      }

      final BlackDeck tempBlackDeck = loadBlackDeck(cardSets);
      if (tempBlackDeck.totalCount() < MINIMUM_BLACK_CARDS) {
        return false;
      }

      final WhiteDeck tempWhiteDeck = loadWhiteDeck(cardSets);
      if (tempWhiteDeck.totalCount() < getRequiredWhiteCardCount()) {
        return false;
      }

      return true;
    }
  }

  /**
   * Deal cards for this round. The game immediately then moves into the {@code PLAYING} state.
   * <br/>
   */
  private void dealState() {
    final Player[] playersCopy = players.toArray(new Player[players.size()]);
    for (final Player player : playersCopy) {
      final List<WhiteCard> hand = player.getHand();
      final List<WhiteCard> newCards = new LinkedList<WhiteCard>();
      while (hand.size() < 10) {
        final WhiteCard card = getNextWhiteCard();
        hand.add(card);
        newCards.add(card);
        metrics.cardDealt(currentUniqueId, player.getUser().getSessionId(), card, dealSeq++);
      }
      sendCardsToPlayer(player, newCards);
    }
    playingState();
  }

  /**
   * Move the game into the {@code PLAYING} state, drawing a new Black Card and dispatching a
   * message to all players.
   * <br/>
   * Synchronizes on {@link #players}, {@link #blackCardLock}, and {@link #roundTimerLock}.
   */
  private void playingState() {
    final GameState oldState = state;
    state = GameState.PLAYING;

    playedCards.clear();

    BlackCard newBlackCard;

    synchronized (blackCardLock) {
      if (blackCard != null) {
        blackDeck.discard(blackCard);
      }
      newBlackCard = blackCard = getNextBlackCard();
    }
    if (newBlackCard.getDraw() > 0) {
      synchronized (players) {
        for (final Player player : players) {
          if (getJudge() == player) {
            continue;
          }
          final List<WhiteCard> cards = new ArrayList<WhiteCard>(newBlackCard.getDraw());
          for (int i = 0; i < newBlackCard.getDraw(); i++) {
            cards.add(getNextWhiteCard());
          }
          player.getHand().addAll(cards);
          sendCardsToPlayer(player, cards);
        }
      }
    }

    // Perhaps figure out a better way to do this...
    final int playTimer = calculateTime(PLAY_TIMEOUT_BASE + (PLAY_TIMEOUT_PER_CARD * blackCard.getPick()));

    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_STATE_CHANGE.toString());
    data.put(LongPollResponse.BLACK_CARD, getBlackCard());
    data.put(LongPollResponse.GAME_STATE, GameState.PLAYING.toString());
    data.put(LongPollResponse.PLAY_TIMER, playTimer);
    // if we're moving from lobby to playing, this is the first round
    if (GameState.LOBBY == oldState) {
      maybeAddPermalinkToData(data);
    }

    broadcastToPlayers(MessageType.GAME_EVENT, data);

    synchronized (roundTimerLock) {
      final SafeTimerTask task = new SafeTimerTask() {
        @Override
        public void process() {
          warnPlayersToPlay();
        }
      };
      // 10 second warning
      rescheduleTimer(task, playTimer - 10 * 1000);
    }
  }

  private int calculateTime(final int base) {
    double factor = 1.0d;
    final String tm = options.timerMultiplier;

    if(tm.equals("Unlimited")) {
      return Integer.MAX_VALUE;
    }

    if(FINITE_PLAYTIMES.contains(tm))
    {
      factor = Double.valueOf(tm.substring(0, tm.length() - 1));
    }

    final long retval = Math.round(base * factor);

    if(retval > Integer.MAX_VALUE) {
      return Integer.MAX_VALUE;
    }

    return (int) retval;
  }

  /**
   * Warn players that have not yet played that they are running out of time to do so.
   * <br/>
   * Synchronizes on {@link #roundTimerLock} and {@link #roundPlayers}.
   */
  private void warnPlayersToPlay() {
    // have to do this all synchronized in case they play while we're processing this
    synchronized (roundTimerLock) {
      killRoundTimer();

      synchronized (roundPlayers) {
        for (final Player player : roundPlayers) {
          final List<WhiteCard> cards = playedCards.getCards(player);
          if (cards == null || cards.size() < blackCard.getPick()) {
            final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
            data.put(LongPollResponse.EVENT, LongPollEvent.HURRY_UP.toString());
            data.put(LongPollResponse.GAME_ID, this.id);
            final QueuedMessage q = new QueuedMessage(MessageType.GAME_EVENT, data);
            player.getUser().enqueueMessage(q);
          }
        }
      }

      final SafeTimerTask task = new SafeTimerTask() {
        @Override
        public void process() {
          skipIdlePlayers();
        }
      };
      // 10 seconds to finish playing
      rescheduleTimer(task, 10 * 1000);
    }
  }

  private void warnJudgeToJudge() {
    // have to do this all synchronized in case they play while we're processing this
    synchronized (roundTimerLock) {
      killRoundTimer();

      if (state == GameState.JUDGING) {
        final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
        data.put(LongPollResponse.EVENT, LongPollEvent.HURRY_UP.toString());
        data.put(LongPollResponse.GAME_ID, this.id);
        final QueuedMessage q = new QueuedMessage(MessageType.GAME_EVENT, data);
        getJudge().getUser().enqueueMessage(q);
      }

      final SafeTimerTask task = new SafeTimerTask() {
        @Override
        public void process() {
          skipIdleJudge();
        }
      };
      // 10 seconds to finish playing
      rescheduleTimer(task, 10 * 1000);
    }
  }

  private void skipIdleJudge() {
    killRoundTimer();
    // prevent them from playing a card while we kick them (or us kicking them while they play!)
    synchronized (judgeLock) {
      if (state != GameState.JUDGING) {
        return;
      }
      // Not sure why this would happen but it has happened before.
      // I guess they disconnected at the exact wrong time?
      final Player judge = getJudge();
      String judgeName = "[unknown]";
      if (judge != null) {
        judge.skipped();
        judgeName = judge.getUser().getNickname();
      }
      logger.info(String.format("Skipping idle judge %s in game %d", judgeName, id));
      final HashMap<ReturnableData, Object> data = getEventMap();
      data.put(LongPollResponse.EVENT, LongPollEvent.GAME_JUDGE_SKIPPED.toString());
      broadcastToPlayers(MessageType.GAME_EVENT, data);
      returnCardsToHand();
      startNextRound();
    }
  }

  private void skipIdlePlayers() {
    killRoundTimer();
    final List<User> playersToRemove = new ArrayList<User>();
    final List<Player> playersToUpdateStatus = new ArrayList<Player>();
    synchronized (roundPlayers) {

      for (final Player player : roundPlayers) {
        final List<WhiteCard> cards = playedCards.getCards(player);
        if (cards == null || cards.size() < blackCard.getPick()) {
          logger.info(String.format("Skipping idle player %s in game %d.", player, id));
          player.skipped();

          final HashMap<ReturnableData, Object> data = getEventMap();
          data.put(LongPollResponse.NICKNAME, player.getUser().getNickname());
          if (player.getSkipCount() >= MAX_SKIPS_BEFORE_KICK || playedCards.size() < 2) {
            data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_KICKED_IDLE.toString());
            playersToRemove.add(player.getUser());
          } else {
            data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_SKIPPED.toString());
            playersToUpdateStatus.add(player);
          }
          broadcastToPlayers(MessageType.GAME_EVENT, data);

          // put their cards back
          final List<WhiteCard> returnCards = playedCards.remove(player);
          if (returnCards != null) {
            player.getHand().addAll(returnCards);
            sendCardsToPlayer(player, returnCards);
          }
        }
      }
    }

    for (final User user : playersToRemove) {
      removePlayer(user);
      final HashMap<ReturnableData, Object> data = getEventMap();
      data.put(LongPollResponse.EVENT, LongPollEvent.KICKED_FROM_GAME_IDLE.toString());
      final QueuedMessage q = new QueuedMessage(MessageType.GAME_PLAYER_EVENT, data);
      user.enqueueMessage(q);
    }

    synchronized (playedCards) {
      if (state == GameState.PLAYING || playersToRemove.size() == 0) {
        // not sure how much of this check is actually required
        if (players.size() < 3 || playedCards.size() < 2) {
          logger.info(String.format(
              "Resetting game %d due to insufficient players after removing %d idle players.",
              id, playersToRemove.size()));
          resetState(true);
        } else {
          judgingState();
        }
      }
    }

    // have to do this after we move to judging state
    for (final Player player : playersToUpdateStatus) {
      notifyPlayerInfoChange(player);
    }
  }

  private void killRoundTimer() {
    synchronized (roundTimerLock) {
      if (null != lastScheduledFuture) {
        logger.trace(String.format("Killing timer task %s", lastScheduledFuture));
        lastScheduledFuture.cancel(false);
        lastScheduledFuture = null;
      }
    }
  }

  private void rescheduleTimer(final SafeTimerTask task, final long timeout) {
    synchronized (roundTimerLock) {
      killRoundTimer();
      logger.trace(String.format("Scheduling timer task %s after %d ms", task, timeout));
      lastScheduledFuture = globalTimer.schedule(task, timeout, TimeUnit.MILLISECONDS);
    }
  }

  /**
   * Move the game into the {@code JUDGING} state.
   */
  private void judgingState() {
    killRoundTimer();
    state = GameState.JUDGING;

    // Perhaps figure out a better way to do this...
    final int judgeTimer = calculateTime(JUDGE_TIMEOUT_BASE + (JUDGE_TIMEOUT_PER_CARD * playedCards.size() * blackCard.getPick()));

    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_STATE_CHANGE.toString());
    data.put(LongPollResponse.GAME_STATE, GameState.JUDGING.toString());
    data.put(LongPollResponse.WHITE_CARDS, getWhiteCards());
    data.put(LongPollResponse.PLAY_TIMER, judgeTimer);
    broadcastToPlayers(MessageType.GAME_EVENT, data);

    notifyPlayerInfoChange(getJudge());

    synchronized (roundTimerLock) {
      final SafeTimerTask task = new SafeTimerTask() {
        @Override
        public void process() {
          warnJudgeToJudge();
        }
      };
      // 10 second warning
      rescheduleTimer(task, judgeTimer - 10 * 1000);
    }
  }

  /**
   * Move the game into the {@code WIN} state, which really just moves into the game reset logic.
   */
  private void winState() {
    resetState(false);
  }

  /**
   * Reset the game state to a lobby.
   *
   * TODO change the message sent to the client if the game reset due to insufficient players.
   *
   * @param lostPlayer
   *          True if because there are no long enough people to play a game, false if because the
   *          previous game finished.
   */
  public void resetState(final boolean lostPlayer) {
    logger.info(String.format("Resetting game %d to lobby (lostPlayer=%b)", id, lostPlayer));
    killRoundTimer();
    synchronized (players) {
      for (final Player player : players) {
        player.getHand().clear();
        player.resetScore();
      }
    }
    whiteDeck = null;
    blackDeck = null;
    synchronized (blackCardLock) {
      blackCard = null;
    }
    playedCards.clear();
    roundPlayers.clear();
    state = GameState.LOBBY;
    currentUniqueId = null;
    final Player judge = getJudge();
    judgeIndex = 0;

    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_STATE_CHANGE.toString());
    data.put(LongPollResponse.GAME_STATE, GameState.LOBBY.toString());
    broadcastToPlayers(MessageType.GAME_EVENT, data);

    if (host != null) {
      notifyPlayerInfoChange(host);
    }

    if (judge != null) {
      notifyPlayerInfoChange(judge);
    }

    gameManager.broadcastGameListRefresh();
  }

  /**
   * Check to see if judging should begin, based on the number of players that have played and the
   * number of cards they have played.
   *
   * @return True if judging should begin.
   */
  private boolean startJudging() {
    if (state != GameState.PLAYING) {
      return false;
    }
    if (playedCards.size() == roundPlayers.size()) {
      boolean startJudging = true;
      for (final List<WhiteCard> cards : playedCards.cards()) {
        if (cards.size() != blackCard.getPick()) {
          startJudging = false;
          break;
        }
      }
      return startJudging;
    } else {
      return false;
    }
  }

  /**
   * Start the next round. Clear out the list of played cards into the discard pile, pick a new
   * judge, set the list of players participating in the round, and move into the {@code DEALING}
   * state.
   */
  private void startNextRound() {
    killRoundTimer();

    synchronized (playedCards) {
      for (final List<WhiteCard> cards : playedCards.cards()) {
        for (final WhiteCard card : cards) {
          whiteDeck.discard(card);
        }
      }
    }

    synchronized (players) {
      judgeIndex++;
      if (judgeIndex >= players.size()) {
        judgeIndex = 0;
      }
      roundPlayers.clear();
      for (final Player player : players) {
        if (player != getJudge()) {
          roundPlayers.add(player);
        }
      }
    }

    dealState();
  }

  /**
   * @return A HashMap to use for events dispatched from this game, with the game id already set.
   */
  public HashMap<ReturnableData, Object> getEventMap() {
    final HashMap<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
    data.put(LongPollResponse.GAME_ID, id);
    return data;
  }

  /**
   * @return The next White Card from the deck, reshuffling if required.
   */
  private WhiteCard getNextWhiteCard() {
    try {
      return whiteDeck.getNextCard();
    } catch (final OutOfCardsException e) {
      whiteDeck.reshuffle();
      final HashMap<ReturnableData, Object> data = getEventMap();
      data.put(LongPollResponse.EVENT, LongPollEvent.GAME_WHITE_RESHUFFLE.toString());
      broadcastToPlayers(MessageType.GAME_EVENT, data);
      return getNextWhiteCard();
    }
  }

  /**
   * @return The next Black Card from the deck, reshuffling if required.
   */
  private BlackCard getNextBlackCard() {
    try {
      return blackDeck.getNextCard();
    } catch (final OutOfCardsException e) {
      blackDeck.reshuffle();
      final HashMap<ReturnableData, Object> data = getEventMap();
      data.put(LongPollResponse.EVENT, LongPollEvent.GAME_BLACK_RESHUFFLE.toString());
      broadcastToPlayers(MessageType.GAME_EVENT, data);
      return getNextBlackCard();
    }
  }

  /**
   * Get the {@code Player} object for a given {@code User} object.
   *
   * @param user
   * @return The {@code Player} object representing {@code user} in this game, or {@code null} if
   *         {@code user} is not in this game.
   */
  @Nullable
  public Player getPlayerForUser(final User user) {
    final Player[] playersCopy = players.toArray(new Player[players.size()]);
    for (final Player player : playersCopy) {
      if (player.getUser() == user) {
        return player;
      }
    }
    return null;
  }

  /**
   * Synchronizes on {@link #blackCardLock}.
   *
   * @return Client data for the current {@code BlackCard}, or {@code null} if there is not a
   *         {@code BlackCard}.
   */
  public Map<BlackCardData, Object> getBlackCard() {
    synchronized (blackCardLock) {
      if (blackCard != null) {
        return blackCard.getClientData();
      } else {
        return null;
      }
    }
  }

  /**
   * @return The "real" white cards played.
   */
  private List<List<Map<WhiteCardData, Object>>> getWhiteCards() {
    if (state != GameState.JUDGING) {
      return new ArrayList<List<Map<WhiteCardData, Object>>>();
    } else {
      final List<List<WhiteCard>> shuffledPlayedCards;
      shuffledPlayedCards = new ArrayList<List<WhiteCard>>(playedCards.cards());
      // list of all sets of cards played, which have data. this looks terrible...
      final List<List<Map<WhiteCardData, Object>>> cardData =
          new ArrayList<List<Map<WhiteCardData, Object>>>(shuffledPlayedCards.size());
      Collections.shuffle(shuffledPlayedCards);
      for (final List<WhiteCard> cards : shuffledPlayedCards) {
        cardData.add(getWhiteCardData(cards));
      }
      return cardData;
    }
  }

  /**
   * @param user
   *          User to return white cards for.
   * @return The white cards the specified user can see, i.e., theirs and face-down cards for
   *         everyone else.
   */
  public List<List<Map<WhiteCardData, Object>>> getWhiteCards(final User user) {
    // if we're in judge mode, return all of the cards and ignore which user is asking
    if (state == GameState.JUDGING) {
      return getWhiteCards();
    } else if (state != GameState.PLAYING) {
      return new ArrayList<List<Map<WhiteCardData, Object>>>();
    } else {
      // getPlayerForUser synchronizes on players. This has caused a deadlock in the past.
      // Good idea to not nest synchronizes if possible anyway.
      final Player player = getPlayerForUser(user);
      synchronized (playedCards) {
        final List<List<Map<WhiteCardData, Object>>> cardData =
            new ArrayList<List<Map<WhiteCardData, Object>>>(playedCards.size());
        int faceDownCards = playedCards.size();
        if (playedCards.hasPlayer(player)) {
          cardData.add(getWhiteCardData(playedCards.getCards(player)));
          faceDownCards--;
        }
        // TODO make this figure out how many blank cards in each spot, for multi-play cards
        while (faceDownCards-- > 0) {
          cardData.add(Arrays.asList(WhiteCard.getFaceDownCardClientData()));
        }
        return cardData;
      }
    }
  }

  /**
   * Convert a list of {@code WhiteCard}s to data suitable for sending to a client.
   *
   * @param cards
   *          Cards to convert to client data.
   * @return Client representation of {@code cards}.
   */
  private List<Map<WhiteCardData, Object>> getWhiteCardData(final List<WhiteCard> cards) {
    final List<Map<WhiteCardData, Object>> data =
        new ArrayList<Map<WhiteCardData, Object>>(cards.size());
    for (final WhiteCard card : cards) {
      data.add(card.getClientData());
    }
    return data;
  }

  /**
   * Send a list of {@code WhiteCard}s to a player.
   *
   * @param player
   *          Player to send the cards to.
   * @param cards
   *          The cards to send the player.
   */
  private void sendCardsToPlayer(final Player player, final List<WhiteCard> cards) {
    final Map<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.HAND_DEAL.toString());
    data.put(LongPollResponse.HAND, getWhiteCardData(cards));
    final QueuedMessage qm = new QueuedMessage(MessageType.GAME_EVENT, data);
    player.getUser().enqueueMessage(qm);
  }

  /**
   * Get a client data representation of a user's hand.
   *
   * @param user
   *          User whose hand to convert to client data.
   * @return Client representation of {@code user}'s hand.
   */
  @Nonnull
  public List<Map<WhiteCardData, Object>> getHand(final User user) {
    final Player player = getPlayerForUser(user);
    if (player != null) {
      final List<WhiteCard> hand = player.getHand();
      synchronized (hand) {
        return getWhiteCardData(hand);
      }
    } else {
      return new ArrayList<Map<WhiteCardData, Object>>(0);
    }
  }

  /**
   * @return A list of all {@code User}s in this game.
   */
  private List<User> playersToUsers() {
    final List<User> users;
    final Player[] playersCopy = players.toArray(new Player[players.size()]);
    users = new ArrayList<User>(playersCopy.length);
    for (final Player player : playersCopy) {
      users.add(player.getUser());
    }
    synchronized (spectators) {
      users.addAll(spectators);
    }
    return users;
  }

  /**
   * @return The judge for the current round, or {@code null} if the judge index is somehow invalid.
   */
  @Nullable
  private Player getJudge() {
    if (judgeIndex >= 0 && judgeIndex < players.size()) {
      return players.get(judgeIndex);
    } else {
      return null;
    }
  }

  /**
   * Play a card.
   *
   * @param user
   *          User playing the card.
   * @param cardId
   *          ID of the card to play.
   * @param cardText
   *          User text for a blank card.  Ignored for normal cards.
   * @return An {@code ErrorCode} if the play was unsuccessful ({@code user} doesn't have the card,
   *         {@code user} is the judge, etc.), or {@code null} if there was no error and the play
   *         was successful.
   */
  public ErrorCode playCard(final User user, final int cardId, final String cardText) {
    final Player player = getPlayerForUser(user);
    if (player != null) {
      player.resetSkipCount();

      if (getJudge() == player || state != GameState.PLAYING) {
        return ErrorCode.NOT_YOUR_TURN;
      }

      synchronized (blackCardLock) {
        if (playedCards.getCardsCount(player) >= blackCard.getPick()) {
          return ErrorCode.PLAYED_ALL_CARDS;
        }
      }

      final List<WhiteCard> hand = player.getHand();
      WhiteCard playCard = null;
      synchronized (hand) {
        final Iterator<WhiteCard> iter = hand.iterator();
        while (iter.hasNext()) {
          final WhiteCard card = iter.next();
          if (card.getId() == cardId) {
            playCard = card;
            if (WhiteDeck.isBlankCard(card)) {
              ((BlankWhiteCard) playCard).setText(cardText);
            }
            // remove the card from their hand. the client will also do so when we return
            // success, so no need to tell it to do so here.
            iter.remove();
            break;
          }
        }
      }
      if (playCard != null) {
        playedCards.addCard(player, playCard);
        notifyPlayerInfoChange(player);

        if (startJudging()) {
          judgingState();
        }
        return null;
      } else {
        return ErrorCode.DO_NOT_HAVE_CARD;
      }
    } else {
      return null;
    }
  }

  /**
   * The judge has selected a card. The {@code cardId} passed in may be any white card's ID for
   * black cards that have multiple selection, however only the first card in the set's ID will be
   * passed around to clients.
   *
   * @param judge
   *          Judge user.
   * @param cardId
   *          Selected card ID.
   * @return Error code if there is an error, or null if success.
   */
  public ErrorCode judgeCard(final User judge, final int cardId) {
    final Player cardPlayer;
    synchronized (judgeLock) {
      final Player judgePlayer = getPlayerForUser(judge);
      if (getJudge() != judgePlayer) {
        return ErrorCode.NOT_JUDGE;
      } else if (state != GameState.JUDGING) {
        return ErrorCode.NOT_YOUR_TURN;
      }

      // shouldn't ever happen, but just in case...
      if (null != judgePlayer) {
        judgePlayer.resetSkipCount();
      }

      cardPlayer = playedCards.getPlayerForId(cardId);
      if (cardPlayer == null) {
        return ErrorCode.INVALID_CARD;
      }

      cardPlayer.increaseScore();
      state = GameState.ROUND_OVER;
    }
    final int clientCardId = playedCards.getCards(cardPlayer).get(0).getId();

    final String roundId = uniqueIdProvider.get();
    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_ROUND_COMPLETE.toString());
    data.put(LongPollResponse.ROUND_WINNER, cardPlayer.getUser().getNickname());
    data.put(LongPollResponse.WINNING_CARD, clientCardId);
    data.put(LongPollResponse.INTERMISSION, ROUND_INTERMISSION);
    if (showRoundLinkProvider.get()) {
      data.put(LongPollResponse.ROUND_PERMALINK,
          String.format(roundPermalinkFormatProvider.get(), roundId));
    }
    broadcastToPlayers(MessageType.GAME_EVENT, data);

    notifyPlayerInfoChange(getJudge());
    notifyPlayerInfoChange(cardPlayer);

    synchronized (roundTimerLock) {
      final SafeTimerTask task;
      // TODO win-by-x option
      if (cardPlayer.getScore() >= options.scoreGoal) {
        task = new SafeTimerTask() {
          @Override
          public void process() {
            winState();
          }
        };
      } else {
        task = new SafeTimerTask() {
          @Override
          public void process() {
            startNextRound();
          }
        };
      }
      rescheduleTimer(task, ROUND_INTERMISSION);
    }

    final Map<String, List<WhiteCard>> cardsBySessionId = new HashMap<>();
    playedCards.cardsByUser().forEach(
        (key, value) -> cardsBySessionId.put(key.getSessionId(), value));
    metrics.roundComplete(currentUniqueId, roundId, judge.getSessionId(),
        cardPlayer.getUser().getSessionId(), blackCard, cardsBySessionId);

    return null;
  }

  /**
   * Exception to be thrown when there are too many players in a game.
   */
  public class TooManyPlayersException extends Exception {
    private static final long serialVersionUID = -6603422097641992017L;
  }

  /**
   * Exception to be thrown when there are too many spectators in a game.
   */
  public class TooManySpectatorsException extends Exception {
    private static final long serialVersionUID = -6603422097641992018L;
  }
}
