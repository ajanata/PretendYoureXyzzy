package net.socialgamer.cah;

public class Constants {
  public enum DisconnectReason {
    MANUAL, PING_TIMEOUT, KICKED
  }

  /**
   * Types of messages that can be queued. The numerical value is the priority that this message
   * should be delivered (lower = more important) compared to other queued messages.
   * 
   * @author ajanata
   */
  public enum MessageType {
    PLAYER_EVENT(3), GAME_PLAYER_EVENT(4), CHAT(5);

    private final int weight;

    MessageType(final int weight) {
      this.weight = weight;
    }

    public int getWeight() {
      return weight;
    }
  }
}
