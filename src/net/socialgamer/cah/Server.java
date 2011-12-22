package net.socialgamer.cah;

import net.socialgamer.cah.data.ConnectedUsers;

import com.google.inject.Singleton;


@Singleton
public class Server {
  private final ConnectedUsers users;

  public Server() {
    users = new ConnectedUsers();
  }

  // TODO figure out if I can just get this to inject directly
  public ConnectedUsers getConnectedUsers() {
    return this.users;
  }
}
