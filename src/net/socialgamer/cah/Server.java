package net.socialgamer.cah;

import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.GameManager;

import com.google.inject.Inject;
import com.google.inject.Singleton;


@Singleton
public class Server {
  private final ConnectedUsers users;
  private final GameManager gameManager;

  @Inject
  public Server(final ConnectedUsers connectedUsers, final GameManager gameManager) {
    users = connectedUsers;
    this.gameManager = gameManager;
  }

  public ConnectedUsers getConnectedUsers() {
    return this.users;
  }

  public GameManager getGameManager() {
    return this.gameManager;
  }
}
