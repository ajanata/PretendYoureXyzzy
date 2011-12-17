package net.socialgamer.cah;

import net.socialgamer.cah.data.ConnectedUsers;


public class Server {
  private final ConnectedUsers users;

  public Server() {
    users = new ConnectedUsers();
  }

  public ConnectedUsers getConnectedUsers() {
    return this.users;
  }
}
