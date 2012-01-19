package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.socialgamer.cah.Constants.GameInfo;
import net.socialgamer.cah.Constants.GameState;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.data.QueuedMessage.MessageType;

import com.google.inject.Inject;


public class Game {
  private final int id;
  private final List<Player> players = new ArrayList<Player>(10);
  private final ConnectedUsers connectedUsers;
  private final GameManager gameManager;
  private Player host;
  private BlackDeck blackDeck;
  private WhiteDeck whiteDeck;
  private GameState state;
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
    data.put(LongPollResponse.EVENT, "game_player_join");
    data.put(LongPollResponse.GAME_ID, id);
    data.put(LongPollResponse.NICKNAME, user.getNickname());
    broadcastToPlayers(MessageType.GAME_PLAYER_EVENT, data);
  }

  /**
   * 
   * @param user
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
          data.put(LongPollResponse.EVENT, "game_player_leave");
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

  public void start() {
    state = GameState.DEALING;
    // TODO deal
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
  }
}
