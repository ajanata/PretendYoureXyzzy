package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

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
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.data.QueuedMessage.MessageType;
import net.socialgamer.cah.db.BlackCard;
import net.socialgamer.cah.db.WhiteCard;

import com.google.inject.Inject;


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
 * 
 * @author ajanata
 */
public class Game {
  private final int id;
  private final List<Player> players = new ArrayList<Player>(10);
  private final List<Player> roundPlayers = new ArrayList<Player>(9);
  // TODO make this Map<Player, List<WhiteCard>> once we support the multiple play black cards
  private final BidiFromIdHashMap<Player, WhiteCard> playedCards =
      new BidiFromIdHashMap<Player, WhiteCard>();
  private final ConnectedUsers connectedUsers;
  private final GameManager gameManager;
  private Player host;
  private BlackDeck blackDeck;
  private BlackCard blackCard;
  private final Object blackCardLock = new Object();
  private WhiteDeck whiteDeck;
  private GameState state;
  // TODO make this host-configurable
  private final int maxPlayers = 10;
  // TODO also need to configure this
  private int judgeIndex = 0;
  private final static int ROUND_INTERMISSION = 8 * 1000;
  private Timer nextRoundTimer;
  private final Object nextRoundTimerLock = new Object();
  // TODO host config
  private final int scoreGoal = 8;

  /**
   * TODO Injection here would be much nicer, but that would need a Provider for the id... Too much
   * work for now.
   * 
   * @param id
   * @param connectedUsers
   * @param gameManager
   */
  @Inject
  public Game(@GameId final Integer id, final ConnectedUsers connectedUsers,
      final GameManager gameManager) {
    this.id = id;
    this.connectedUsers = connectedUsers;
    this.gameManager = gameManager;
    state = GameState.LOBBY;
  }

  /**
   * Add a player to the game.
   * 
   * @param user
   *          Player to add to this game.
   * @throws TooManyPlayersException
   *           Thrown if this game is at its maximum player capacity.
   * @throws IllegalStateException
   *           Thrown if the user is already in a game.
   */
  public void addPlayer(final User user) throws TooManyPlayersException, IllegalStateException {
    synchronized (players) {
      if (maxPlayers >= 3 && players.size() >= maxPlayers) {
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
  }

  /**
   * Remove a player from the game.
   * 
   * TODO adjust judgeIndex if the player removed is at or before the index
   * 
   * TODO remove card they played
   * 
   * TODO start a new round if they were the judge
   * 
   * @param user
   *          Player to remove from the game.
   * @return True if {@code user} was the last player in the game.
   */
  public boolean removePlayer(final User user) {
    boolean wasJudge = false;
    synchronized (players) {
      final Iterator<Player> iterator = players.iterator();
      while (iterator.hasNext()) {
        final Player player = iterator.next();
        if (player.getUser() == user) {
          HashMap<ReturnableData, Object> data = getEventMap();
          data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_LEAVE.toString());
          data.put(LongPollResponse.NICKNAME, user.getNickname());
          broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

          // If they played this round, remove card from played card list.
          synchronized (playedCards) {
            if (playedCards.containsKey(player)) {
              synchronized (whiteDeck) {
                // FIXME for multi-play
                whiteDeck.discard(playedCards.get(player));
              }
              playedCards.remove(player);
            }
          }
          // If they are to play this round, remove them from that list.
          synchronized (roundPlayers) {
            if (roundPlayers.contains(player)) {
              roundPlayers.remove(player);
              if (roundPlayers.size() == playedCards.size()) {
                // FIXME for multi-play
                judgingState();
              }
            }
          }
          // If they have a hand, return it to discard pile.
          if (player.getHand().size() > 0) {
            synchronized (whiteDeck) {
              final List<WhiteCard> hand = player.getHand();
              for (final WhiteCard card : hand) {
                whiteDeck.discard(card);
              }
            }
          }
          // If they are judge, return all played cards to hand, and move to next judge.
          if (getJudge() == player && (state == GameState.PLAYING || state == GameState.JUDGING)) {
            data = getEventMap();
            data.put(LongPollResponse.EVENT, LongPollEvent.GAME_JUDGE_LEFT.toString());
            broadcastToPlayers(MessageType.GAME_EVENT, data);
            synchronized (playedCards) {
              // FIXME for multi-play
              for (final Player p : playedCards.keySet()) {
                p.getHand().add(playedCards.get(p));
                sendCardsToPlayer(p, Arrays.asList(playedCards.get(p)));
              }
              // prevent startNextRound from discarding cards
              playedCards.clear();
            }
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
          iterator.remove();
          user.leaveGame(this);

          if (host == player) {
            if (players.size() > 0) {
              host = players.get(0);
            } else {
              host = null;
            }
          }

          break;
        }
      }
      // this seems terrible
      if (players.size() == 0) {
        gameManager.destroyGame(id);
      }
      if (players.size() < 3 && state != GameState.LOBBY) {
        resetState(true);
      } else if (wasJudge) {
        startNextRound();
      }
      return players.size() == 0;
    }
  }

  public void broadcastToPlayers(final MessageType type,
      final HashMap<ReturnableData, Object> masterData) {
    connectedUsers.broadcastToList(playersToUsers(), type, masterData);
  }

  public GameState getState() {
    return state;
  }

  public User getHost() {
    if (host == null) {
      return null;
    }
    return host.getUser();
  }

  public List<User> getUsers() {
    return playersToUsers();
  }

  public int getId() {
    return id;
  }

  public Map<GameInfo, Object> getInfo() {
    final Map<GameInfo, Object> info = new HashMap<GameInfo, Object>();
    info.put(GameInfo.ID, id);
    info.put(GameInfo.HOST, host.toString());
    info.put(GameInfo.STATE, state.toString());
    synchronized (players) {
      final List<String> playerNames = new ArrayList<String>(players.size());
      for (final Player player : players) {
        playerNames.add(player.toString());
      }
      info.put(GameInfo.PLAYERS, playerNames);
    }
    return info;
  }

  public List<Map<GamePlayerInfo, Object>> getAllPlayerInfo() {
    final List<Map<GamePlayerInfo, Object>> info;
    synchronized (players) {
      info = new ArrayList<Map<GamePlayerInfo, Object>>(
          players.size());
      for (final Player player : players) {
        final Map<GamePlayerInfo, Object> playerInfo = getPlayerInfo(player);
        info.add(playerInfo);
      }
    }
    return info;
  }

  private Map<GamePlayerInfo, Object> getPlayerInfo(final Player player) {
    final Map<GamePlayerInfo, Object> playerInfo = new HashMap<GamePlayerInfo, Object>();
    playerInfo.put(GamePlayerInfo.NAME, player.getUser().getNickname());
    playerInfo.put(GamePlayerInfo.SCORE, player.getScore());
    playerInfo.put(GamePlayerInfo.STATUS, getPlayerStatus(player).toString());

    return playerInfo;
  }

  private GamePlayerStatus getPlayerStatus(final Player player) {
    // TODO fix this once we actually have gameplay logic
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
          synchronized (playedCards) {
            if (playedCards.containsKey(player)) {
              playerStatus = GamePlayerStatus.IDLE;
            } else {
              playerStatus = GamePlayerStatus.PLAYING;
            }
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
        else if (player.getScore() == scoreGoal) {
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
   * 
   * @return True if the game is started. Would only be false if there aren't enough players, or the
   *         game is already started, but hopefully clients would prevent that from happening!
   */
  public boolean start() {
    if (state != GameState.LOBBY) {
      return false;
    }
    synchronized (players) {
      if (players.size() >= 3) {
        blackDeck = new BlackDeck();
        whiteDeck = new WhiteDeck();
        startNextRound();
        return true;
      } else {
        return false;
      }
    }
  }

  /**
   * @return A HashMap to use for events dispatched from this game, with the game id already set.
   */
  private HashMap<ReturnableData, Object> getEventMap() {
    final HashMap<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
    data.put(LongPollResponse.GAME_ID, id);
    return data;
  }

  private void dealState() {
    state = GameState.DEALING;
    synchronized (players) {
      for (final Player player : players) {
        final List<WhiteCard> hand = player.getHand();
        final List<WhiteCard> newCards = new LinkedList<WhiteCard>();
        synchronized (whiteDeck) {
          while (hand.size() < 10) {
            final WhiteCard card;
            try {
              card = whiteDeck.getNextCard();
            } catch (final OutOfCardsException e) {
              whiteDeck.reshuffle();
              final HashMap<ReturnableData, Object> data = getEventMap();
              data.put(LongPollResponse.EVENT, LongPollEvent.GAME_WHITE_RESHUFFLE);
              broadcastToPlayers(MessageType.GAME_EVENT, data);
              continue;
            }
            hand.add(card);
            newCards.add(card);
          }
        }
        sendCardsToPlayer(player, newCards);
      }
    }
    playingState();
  }

  private void playingState() {
    state = GameState.PLAYING;

    synchronized (playedCards) {
      playedCards.clear();
    }

    synchronized (blackCardLock) {
      do {
        try {
          blackDeck.discard(blackCard);
          blackCard = blackDeck.getNextCard();
        } catch (final OutOfCardsException e) {
          blackDeck.reshuffle();
          final HashMap<ReturnableData, Object> data = getEventMap();
          data.put(LongPollResponse.EVENT, LongPollEvent.GAME_BLACK_RESHUFFLE);
          broadcastToPlayers(MessageType.GAME_EVENT, data);
          continue;
        }
        // TODO remove this loop once the game supports the pick and draw features
      } while (blackCard.getPick() != 1 || blackCard.getDraw() != 0);
    }

    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_STATE_CHANGE.toString());
    data.put(LongPollResponse.BLACK_CARD, getBlackCard());
    data.put(LongPollResponse.GAME_STATE, GameState.PLAYING.toString());

    broadcastToPlayers(MessageType.GAME_EVENT, data);
  }

  private void judgingState() {
    state = GameState.JUDGING;

    HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_STATE_CHANGE.toString());
    data.put(LongPollResponse.GAME_STATE, GameState.JUDGING.toString());
    data.put(LongPollResponse.WHITE_CARDS, getWhiteCards());
    broadcastToPlayers(MessageType.GAME_EVENT, data);

    data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_INFO_CHANGE.toString());
    data.put(LongPollResponse.PLAYER_INFO, getPlayerInfo(getJudge()));
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

    // TODO pick a new judge after the judge has selected a winner
    // delay for a short while after the judge selects so that everyone has a chance to see the
    // selection
  }

  private void winState() {
    // TODO announce the victory
    resetState(false);
  }

  /**
   * Reset the game state to a lobby.
   * 
   * @param lostPlayer
   *          True if because there are no long enough people to play a game, false if because the
   *          previous game finished.
   */
  private void resetState(final boolean lostPlayer) {
    synchronized (nextRoundTimerLock) {
      if (nextRoundTimer != null) {
        nextRoundTimer.cancel();
        nextRoundTimer = null;
      }
    }
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
    synchronized (playedCards) {
      playedCards.clear();
    }
    synchronized (roundPlayers) {
      roundPlayers.clear();
    }
    state = GameState.LOBBY;
    final Player judge = getJudge();
    judgeIndex = 0;

    HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_STATE_CHANGE.toString());
    data.put(LongPollResponse.GAME_STATE, GameState.LOBBY.toString());
    broadcastToPlayers(MessageType.GAME_EVENT, data);

    data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_INFO_CHANGE.toString());
    data.put(LongPollResponse.PLAYER_INFO, getPlayerInfo(host));
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

    data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_INFO_CHANGE.toString());
    data.put(LongPollResponse.PLAYER_INFO, getPlayerInfo(judge));
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);
  }

  private void sendCardsToPlayer(final Player player, final List<WhiteCard> cards) {
    final Map<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.HAND_DEAL.toString());
    final List<Map<WhiteCardData, Object>> cardData = handSubsetToClient(cards);
    data.put(LongPollResponse.HAND, cardData);
    final QueuedMessage qm = new QueuedMessage(MessageType.GAME_EVENT, data);
    player.getUser().enqueueMessage(qm);
  }

  private List<Map<WhiteCardData, Object>> handSubsetToClient(final List<WhiteCard> cards) {
    final List<Map<WhiteCardData, Object>> cardData =
        new ArrayList<Map<WhiteCardData, Object>>(cards.size());
    for (final WhiteCard card : cards) {
      final Map<WhiteCardData, Object> thisCard = new HashMap<WhiteCardData, Object>();
      thisCard.put(WhiteCardData.ID, card.getId());
      thisCard.put(WhiteCardData.TEXT, card.getText());
      cardData.add(thisCard);
    }
    return cardData;
  }

  public List<Map<WhiteCardData, Object>> getHand(final User user) {
    final Player player = getPlayerForUser(user);
    if (player != null) {
      final List<WhiteCard> hand = player.getHand();
      synchronized (hand) {
        return handSubsetToClient(player.getHand());
      }
    } else {
      return null;
    }
  }

  private Player getPlayerForUser(final User user) {
    synchronized (players) {
      for (final Player player : players) {
        if (player.getUser() == user) {
          return player;
        }
      }
    }
    return null;
  }

  public Map<BlackCardData, Object> getBlackCard() {
    synchronized (blackCardLock) {
      if (blackCard != null) {
        return blackCard.getClientData();
      } else {
        return null;
      }
    }
  }

  private List<Map<WhiteCardData, Object>> getWhiteCards() {
    if (state != GameState.JUDGING) {
      return new ArrayList<Map<WhiteCardData, Object>>();
    } else {
      // TODO fix this for multi-play
      final List<WhiteCard> shuffledPlayedCards;
      synchronized (playedCards) {
        shuffledPlayedCards = new ArrayList<WhiteCard>(playedCards.values());
      }
      final List<Map<WhiteCardData, Object>> cardData = new ArrayList<Map<WhiteCardData, Object>>(
          shuffledPlayedCards.size());
      Collections.shuffle(shuffledPlayedCards);
      for (final WhiteCard card : shuffledPlayedCards) {
        cardData.add(card.getClientData());
      }
      return cardData;
    }
  }

  public List<Map<WhiteCardData, Object>> getWhiteCards(final User user) {
    // if we're in judge mode, return all of the cards and ignore which user is asking
    if (state == GameState.JUDGING) {
      return getWhiteCards();
    } else if (state != GameState.PLAYING) {
      return new ArrayList<Map<WhiteCardData, Object>>();
    } else {
      // TODO fix this for multi-play
      synchronized (playedCards) {
        final List<Map<WhiteCardData, Object>> cardData = new ArrayList<Map<WhiteCardData, Object>>(
            playedCards.size());
        int blankCards = playedCards.size();
        final Player player = getPlayerForUser(user);
        if (playedCards.containsKey(player)) {
          cardData.add(playedCards.get(player).getClientData());
          blankCards--;
        }
        while (blankCards-- > 0) {
          cardData.add(WhiteCard.getBlankCardClientData());
        }
        return cardData;
      }
    }
  }

  private List<User> playersToUsers() {
    final List<User> users;
    synchronized (players) {
      users = new ArrayList<User>(players.size());
      for (final Player player : players) {
        users.add(player.getUser());
      }
    }
    return users;
  }

  private Player getJudge() {
    if (judgeIndex >= 0 && judgeIndex < players.size()) {
      return players.get(judgeIndex);
    } else {
      return null;
    }
  }

  public ErrorCode playCard(final User user, final int cardId) {
    final Player player = getPlayerForUser(user);
    if (player != null) {
      if (getJudge() == player || state != GameState.PLAYING) {
        return ErrorCode.NOT_YOUR_TURN;
      }
      final List<WhiteCard> hand = player.getHand();
      WhiteCard playCard = null;
      synchronized (hand) {
        final Iterator<WhiteCard> iter = hand.iterator();
        while (iter.hasNext()) {
          final WhiteCard card = iter.next();
          if (card.getId() == cardId) {
            playCard = card;
            // remove the card from their hand. the client will also do so when we return
            // success, so no need to tell it to do so here.
            iter.remove();
            break;
          }
        }
      }
      if (playCard != null) {
        synchronized (playedCards) {
          playedCards.put(player, playCard);

          final HashMap<ReturnableData, Object> data = getEventMap();
          data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_INFO_CHANGE.toString());
          data.put(LongPollResponse.PLAYER_INFO, getPlayerInfo(player));
          broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

          // TODO make this check that everybody has played proper number of cards when we support
          // multiple play blacks
          if (playedCards.size() == roundPlayers.size()) {
            judgingState();
          }
        }
        return null;
      } else {
        return ErrorCode.DO_NOT_HAVE_CARD;
      }
    } else {
      return null;
    }
  }

  public ErrorCode judgeCard(final User user, final int cardId) {
    final Player player = getPlayerForUser(user);
    if (getJudge() != player) {
      return ErrorCode.NOT_JUDGE;
    } else if (state != GameState.JUDGING) {
      return ErrorCode.NOT_YOUR_TURN;
    }

    final Player cardPlayer;
    synchronized (playedCards) {
      cardPlayer = playedCards.getKeyForId(cardId);
    }
    if (cardPlayer == null) {
      return ErrorCode.INVALID_CARD;
    }

    cardPlayer.increaseScore();
    state = GameState.ROUND_OVER;

    HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_ROUND_COMPLETE.toString());
    data.put(LongPollResponse.ROUND_WINNER, cardPlayer.getUser().getNickname());
    data.put(LongPollResponse.WINNING_CARD, cardId);
    data.put(LongPollResponse.INTERMISSION, ROUND_INTERMISSION);
    broadcastToPlayers(MessageType.GAME_EVENT, data);

    data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_INFO_CHANGE.toString());
    data.put(LongPollResponse.PLAYER_INFO, getPlayerInfo(getJudge()));
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

    data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_INFO_CHANGE.toString());
    data.put(LongPollResponse.PLAYER_INFO, getPlayerInfo(cardPlayer));
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

    synchronized (nextRoundTimerLock) {
      nextRoundTimer = new Timer();
      final TimerTask task;
      // TODO win-by-x option
      if (cardPlayer.getScore() == scoreGoal) {
        task = new TimerTask() {
          @Override
          public void run() {
            winState();
          }
        };
      } else {
        task = new TimerTask() {
          @Override
          public void run() {
            startNextRound();
          }
        };
      }
      nextRoundTimer.schedule(task, ROUND_INTERMISSION);
    }

    return null;
  }

  private void startNextRound() {
    synchronized (whiteDeck) {
      synchronized (playedCards) {
        for (final WhiteCard card : playedCards.values()) {
          // TODO fix this for multiple played cards
          whiteDeck.discard(card);
        }
      }
    }

    synchronized (players) {
      judgeIndex++;
      if (judgeIndex >= players.size()) {
        judgeIndex = 0;
      }
      synchronized (roundPlayers) {
        roundPlayers.clear();
        for (final Player player : players) {
          if (player != getJudge()) {
            roundPlayers.add(player);
          }
        }
      }
    }

    dealState();
  }

  public class TooManyPlayersException extends Exception {
    private static final long serialVersionUID = -6603422097641992017L;
  }
}
