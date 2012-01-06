package net.socialgamer.cah;

import java.util.TimerTask;

import net.socialgamer.cah.data.ConnectedUsers;

import com.google.inject.Inject;


public class UserPing extends TimerTask {

  private final ConnectedUsers users;

  @Inject
  public UserPing(final Server server) {
    users = server.getConnectedUsers();
  }

  @Override
  public void run() {
    users.checkForPingTimeouts();
  }
}
