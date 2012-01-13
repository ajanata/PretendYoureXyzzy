package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import net.socialgamer.cah.Constants.DisconnectReason;
import net.socialgamer.cah.data.QueuedMessage.MessageType;


/**
 * Class that holds all users connected to the server, and provides functions to operate on said
 * list.
 * 
 * @author ajanata
 * 
 */
public class ConnectedUsers {

  /**
   * Duration of a ping timeout, in nanoseconds.
   */
  public static final long PING_TIMEOUT = 3L * 60L * 1000L * 1000000L;
  //  public static final long PING_TIMEOUT = 30L * 1000L * 1000000L;

  private final Map<String, User> users = new HashMap<String, User>();

  public boolean hasUser(final String userName) {
    return users.containsKey(userName);
  }

  public void newUser(final User user) {
    synchronized (users) {
      users.put(user.getNickname(), user);
      final HashMap<String, Object> data = new HashMap<String, Object>();
      data.put("event", "new_player");
      data.put("nickname", user.getNickname());
      broadcastToAll(MessageType.PLAYER_EVENT, data);
    }
  }

  public void removeUser(final User user, final DisconnectReason reason) {
    synchronized (users) {
      users.remove(user.getNickname());
      notifyRemoveUser(user, reason);
    }
  }

  private void notifyRemoveUser(final User user, final DisconnectReason reason) {
    // We might also have to tell games about this directly, probably with a listener system.
    final HashMap<String, Object> data = new HashMap<String, Object>();
    data.put("event", "player_leave");
    data.put("nickname", user.getNickname());
    data.put("reason", reason.toString());
    broadcastToAll(MessageType.PLAYER_EVENT, data);
  }

  public void checkForPingTimeouts() {
    synchronized (users) {
      final Iterator<User> iterator = users.values().iterator();
      while (iterator.hasNext()) {
        final User u = iterator.next();
        if (System.nanoTime() - u.getLastHeardFrom() > PING_TIMEOUT) {
          u.noLongerVaild();
          notifyRemoveUser(u, DisconnectReason.PING_TIMEOUT);
          iterator.remove();
        }
      }
    }
  }

  /**
   * Broadcast a message to all connected players.
   * 
   * @param type
   * @param masterData
   */
  public void broadcastToAll(final MessageType type, final HashMap<String, Object> masterData) {
    broadcastToList(users.values(), type, masterData);
  }

  /**
   * Broadcast a message to a specified subset of connected players.
   * 
   * @param broadcastTo
   * @param type
   * @param masterData
   */
  public void broadcastToList(final Collection<User> broadcastTo, final MessageType type,
      final HashMap<String, Object> masterData) {
    synchronized (users) {
      for (final User u : broadcastTo) {
        @SuppressWarnings("unchecked")
        final Map<String, Object> data = (Map<String, Object>) masterData.clone();
        data.put("timestamp", System.currentTimeMillis());
        final QueuedMessage qm = new QueuedMessage(type, data);
        u.enqueueMessage(qm);
      }
    }
  }

  public Collection<User> getUsers() {
    // return a copy
    synchronized (users) {
      return new ArrayList<User>(users.values());
    }
  }
}
