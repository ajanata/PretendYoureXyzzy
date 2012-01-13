package net.socialgamer.cah;

public class Constants {
  public enum DisconnectReason {
    KICKED("kicked"), MANUAL("manual"), PING_TIMEOUT("ping_timeout");

    private final String reason;

    DisconnectReason(final String reason) {
      this.reason = reason;
    }

    @Override
    public String toString() {
      return reason;
    }
  }

  public enum AjaxOperation {
    CHAT("chat"), FIRST_LOAD("firstload"), LOG_OUT("logout"), NAMES("names"), REGISTER("register");

    private final String op;

    AjaxOperation(final String op) {
      this.op = op;
    }

    @Override
    public String toString() {
      return op;
    }
  }
}
