package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import net.socialgamer.cah.data.QueuedMessage.MessageType;


public class Game {
  private final int id;
  private final List<Player> players = new ArrayList<Player>(10);
  private final ConnectedUsers connectedUsers;
  private Player host;
  private BlackDeck blackDeck;
  private WhiteDeck whiteDeck;

  /**
   * TODO Injection here would be much nicer, but that would need a Provider for the id... Too much
   * work for now.
   * 
   * @param id
   * @param connectedUsers
   */
  public Game(final int id, final ConnectedUsers connectedUsers) {
    this.id = id;
    this.connectedUsers = connectedUsers;
  }

  public void addPlayer(final User user) {
    final Player player = new Player(user);
    synchronized (players) {
      players.add(player);
      if (host == null) {
        host = player;
      }
    }

    final HashMap<String, Object> data = new HashMap<String, Object>();
    data.put("event", "game_player_join");
    data.put("game_id", id);
    data.put("nickname", user.getNickname());
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
          final HashMap<String, Object> data = new HashMap<String, Object>();
          data.put("event", "game_player_leave");
          data.put("game_id", id);
          data.put("nickname", user.getNickname());
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
      return players.size() == 0;
    }
  }

  public void broadcastToPlayers(final MessageType type, final HashMap<String, Object> masterData) {
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
}
