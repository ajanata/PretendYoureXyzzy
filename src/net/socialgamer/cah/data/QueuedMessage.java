package net.socialgamer.cah.data;

import java.util.Map;


public class QueuedMessage implements Comparable<QueuedMessage> {

  private final Type messageType;
  private final Map<String, Object> data;

  public QueuedMessage(final Type messageType, final Map<String, Object> data) {
    this.messageType = messageType;
    this.data = data;
  }

  public Type getMessageType() {
    return messageType;
  }

  public Map<String, Object> getData() {
    return data;
  }

  /**
   * This is not guaranteed to be consistent with .equals() since we do not care about the data for
   * ordering.
   */
  @Override
  public int compareTo(final QueuedMessage qm) {
    return this.messageType.getWeight() - qm.messageType.getWeight();
  }

  /**
   * Types of messages that can be queued. The numerical value is the priority that this message
   * should be delivered (lower = more important) compared to other queued messages.
   * 
   * @author ajanata
   * 
   */
  public enum Type {
    PING(0), NEW_PLAYER(3), PLAYER_DISCONNECT(3), CHAT(5);

    private final int weight;

    Type(final int weight) {
      this.weight = weight;
    }

    public int getWeight() {
      return weight;
    }
  }

}
