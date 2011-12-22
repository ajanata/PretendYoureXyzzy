package net.socialgamer.cah.data;

import java.util.HashMap;
import java.util.Map;

import net.socialgamer.cah.data.QueuedMessage.Type;


public class ConnectedUsers {

  private final Map<String, User> users = new HashMap<String, User>();

  public boolean hasUser(final String userName) {
    return users.containsKey(userName);
  }

  public void newUser(final User user) {
    // TODO fire an event for a new user to interested parties
    synchronized (users) {
      users.put(user.getNickname(), user);
      for (final User u : users.values()) {
        final Map<String, Object> data = new HashMap<String, Object>();
        data.put("event", "newplayer");
        data.put("nickname", user.getNickname());
        data.put("timestamp", System.currentTimeMillis());
        final QueuedMessage qm = new QueuedMessage(Type.NEW_PLAYER, data);
        u.enqueueMessage(qm);
      }
    }
  }

  public void removeUser(final User user, final User.DisconnectReason reason) {
    // TODO fire an event for a disconnected user to interested parties
    synchronized (users) {

    }
  }
}
