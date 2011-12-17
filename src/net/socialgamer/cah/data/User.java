package net.socialgamer.cah.data;

public class User {

  enum DisconnectReason {
    MANUAL, PING_TIMEOUT, KICKED
  }

  private final String nickname;

  public User(final String nickname) {
    this.nickname = nickname;
  }

  public String getNickname() {
    return nickname;
  }

}
