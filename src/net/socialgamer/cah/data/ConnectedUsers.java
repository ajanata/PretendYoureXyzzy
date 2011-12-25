package net.socialgamer.cah.data;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import net.socialgamer.cah.data.QueuedMessage.Type;


/**
 * Class that holds all users connected to the server, and provides functions to operate on said
 * list.
 * 
 * @author ajanata
 * 
 */
public class ConnectedUsers {

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
      broadcastToAll(Type.NEW_PLAYER, data);
    }
  }

  public void removeUser(final User user, final User.DisconnectReason reason) {
    // TODO fire an event for a disconnected user to interested parties
    //    synchronized (users) {
    //
    //    }
  }

  /**
   * Broadcast a message to all connected players.
   * 
   * @param type
   * @param masterData
   */
  public void broadcastToAll(final Type type, final HashMap<String, Object> masterData) {
    broadcastToList(users.values(), type, masterData);
  }

  /**
   * Broadcast a message to a specified subset of connected players.
   * 
   * @param broadcastTo
   * @param type
   * @param masterData
   */
  public void broadcastToList(final Collection<User> broadcastTo, final Type type,
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
}
