package net.socialgamer.cah.data;

public class Player {
  private final User user;

  public Player(final User user) {
    this.user = user;
  }

  public User getUser() {
    return user;
  }
}
