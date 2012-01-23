package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

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
  private final ConnectedUsers connectedUsers;
  private final GameManager gameManager;
  private Player host;
  private BlackDeck blackDeck;
  private WhiteDeck whiteDeck;
  private GameState state;
  // TODO make this work with "draw x" cards. probably will not actually be done here.
  private final int currentHandSize = 10;
  // TODO make this host-configurable
  private final int maxPlayers = 10;

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
      return players.size() == 0;
    }
  }

  public void broadcastToPlayers(final MessageType type,
      final HashMap<ReturnableData, Object> masterData) {
    connectedUsers.broadcastToList(playersToUsers(), type, masterData);
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

  public List<Map<GamePlayerInfo, Object>> getPlayerInfo() {
    final List<Map<GamePlayerInfo, Object>> info;
    synchronized (players) {
      info = new ArrayList<Map<GamePlayerInfo, Object>>(
          players.size());
      for (final Player player : players) {
        final Map<GamePlayerInfo, Object> playerInfo = new HashMap<GamePlayerInfo, Object>();
        playerInfo.put(GamePlayerInfo.NAME, player.getUser().getNickname());
        playerInfo.put(GamePlayerInfo.SCORE, player.getScore());
        // TODO fix this once we actually have gameplay logic
        if (state == GameState.LOBBY && host == player) {
          playerInfo.put(GamePlayerInfo.STATUS, GamePlayerStatus.HOST.toString());
        } else {
          playerInfo.put(GamePlayerInfo.STATUS, GamePlayerStatus.IDLE.toString());
        }
        info.add(playerInfo);
      }
    }
    return info;
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
        sendDealtCardsToPlayer(player, newCards);
      }
    }
  }

  private void sendDealtCardsToPlayer(final Player player, final List<WhiteCard> cards) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
    data.put(LongPollResponse.EVENT, LongPollEvent.HAND_DEAL.toString());
    data.put(LongPollResponse.GAME_ID, id);
    final List<Map<WhiteCardData, Object>> cardData =
        new ArrayList<Map<WhiteCardData, Object>>(cards.size());
    for (final WhiteCard card : cards) {
      final Map<WhiteCardData, Object> thisCard = new HashMap<WhiteCardData, Object>();
      thisCard.put(WhiteCardData.ID, card.getId());
      thisCard.put(WhiteCardData.TEXT, card.getText());
      cardData.add(thisCard);
    }
    data.put(LongPollResponse.HAND, cardData);
    final QueuedMessage qm = new QueuedMessage(MessageType.GAME_EVENT, data);
    player.getUser().enqueueMessage(qm);
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

  public class TooManyPlayersException extends Exception {
    private static final long serialVersionUID = -6603422097641992017L;
  }
}
