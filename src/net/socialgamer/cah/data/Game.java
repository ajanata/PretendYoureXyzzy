package net.socialgamer.cah.data;

import java.util.ArrayList;
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
  // TODO make this work with "draw x" cards. probably will not actually be done here.
  private final int currentHandSize = 10;
  // TODO make this host-configurable
  private final int maxPlayers = 10;
  private int judgeIndex = 0;
  private final static int ROUND_INTERMISSION = 8 * 1000;

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

    final HashMap<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_JOIN.toString());
    data.put(LongPollResponse.GAME_ID, id);
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
    synchronized (players) {
      final Iterator<Player> iterator = players.iterator();
      while (iterator.hasNext()) {
        final Player player = iterator.next();
        if (player.getUser() == user) {
          iterator.remove();
          user.leaveGame(this);
          final HashMap<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
          data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_LEAVE.toString());
          data.put(LongPollResponse.GAME_ID, id);
          data.put(LongPollResponse.NICKNAME, user.getNickname());
          broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);
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
        playerStatus = GamePlayerStatus.IDLE;
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
        dealState();
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
        while (hand.size() < currentHandSize) {
          final WhiteCard card = whiteDeck.getNextCard();
          hand.add(card);
          newCards.add(card);
        }
        sendCardsToPlayer(player, newCards);
      }
    }
    playingState();
  }

  private void playingState() {
    state = GameState.PLAYING;

    playedCards.clear();

    synchronized (blackCardLock) {
      do {
        blackCard = blackDeck.getNextCard();
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
    // Reset the game.
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
    state = GameState.LOBBY;
    judgeIndex = 0;

    final HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_STATE_CHANGE.toString());
    data.put(LongPollResponse.GAME_STATE, GameState.LOBBY.toString());
    broadcastToPlayers(MessageType.GAME_EVENT, data);
  }

  private void sendCardsToPlayer(final Player player, final List<WhiteCard> cards) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
    data.put(LongPollResponse.EVENT, LongPollEvent.HAND_DEAL.toString());
    data.put(LongPollResponse.GAME_ID, id);
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
    return players.get(judgeIndex);
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

          final HashMap<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
          data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_INFO_CHANGE.toString());
          data.put(LongPollResponse.GAME_ID, id);
          data.put(LongPollResponse.PLAYER_INFO, getPlayerInfo(player));
          broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

          // TODO make this check that everybody has played proper number of cards when we support
          // multiple play blacks
          if (playedCards.size() == players.size() - 1) {
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

    HashMap<ReturnableData, Object> data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_ROUND_COMPLETE.toString());
    data.put(LongPollResponse.ROUND_WINNER, cardPlayer.getUser().getNickname());
    data.put(LongPollResponse.WINNING_CARD, cardId);
    data.put(LongPollResponse.INTERMISSION, ROUND_INTERMISSION);
    broadcastToPlayers(MessageType.GAME_EVENT, data);

    data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_INFO_CHANGE.toString());
    data.put(LongPollResponse.PLAYER_INFO, getPlayerInfo(getJudge()));
    state = GameState.ROUND_OVER;
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

    data = getEventMap();
    data.put(LongPollResponse.EVENT, LongPollEvent.GAME_PLAYER_INFO_CHANGE.toString());
    data.put(LongPollResponse.PLAYER_INFO, getPlayerInfo(cardPlayer));
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);

    final Timer timer = new Timer();
    timer.schedule(new TimerTask() {
      @Override
      public void run() {
        startNextRound();
      }
    }, ROUND_INTERMISSION);

    return null;
  }

  private void startNextRound() {
    synchronized (players) {
      judgeIndex++;
      if (judgeIndex >= players.size()) {
        judgeIndex = 0;
      }
    }

    dealState();
  }

  public class TooManyPlayersException extends Exception {
    private static final long serialVersionUID = -6603422097641992017L;
  }
}
