package net.socialgamer.cah;

import net.socialgamer.cah.data.ConnectedUsers;

import com.google.inject.AbstractModule;


public class CahModule extends AbstractModule {

  private final Server server;

  public CahModule(final Server server) {
    this.server = server;
  }

  @Override
  protected void configure() {
    // TODO Auto-generated method stub
    bind(ConnectedUsers.class).toInstance(server.getConnectedUsers());
  }

}
