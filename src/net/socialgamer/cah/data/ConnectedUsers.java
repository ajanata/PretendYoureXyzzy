package net.socialgamer.cah.data;

import java.util.HashMap;
import java.util.Map;


public class ConnectedUsers {

  private final Map<String, User> users = new HashMap<String, User>();

  public boolean hasUser(final String userName) {
    return users.containsKey(userName);
  }

  public void newUser(final User user) {
    // TODO fire an event for a new user to interested parties
    users.put(user.getNickname(), user);
  }

  public void removeUser(final User user, final User.DisconnectReason reason) {
    // TODO fire an event for a disconnected user to interested parties
  }
}
