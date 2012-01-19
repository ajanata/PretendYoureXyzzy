package net.socialgamer.cah.data;

public class Player {
  private final User user;

  // TODO add their hand, etc.

  public Player(final User user) {
    this.user = user;
  }

  public User getUser() {
    return user;
  }

  @Override
  public String toString() {
    return user.toString();
  }
}
