package net.socialgamer.cah.data;

import java.util.Map;

import net.socialgamer.cah.Constants.ReturnableData;


public class QueuedMessage implements Comparable<QueuedMessage> {

  private final MessageType messageType;
  private final Map<ReturnableData, Object> data;

  public QueuedMessage(final MessageType messageType, final Map<ReturnableData, Object> data) {
    this.messageType = messageType;
    this.data = data;
  }

  public MessageType getMessageType() {
    return messageType;
  }

  public Map<ReturnableData, Object> getData() {
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

  @Override
  public String toString() {
    return messageType.toString() + "_" + data.toString();
  }

  /**
   * Types of messages that can be queued. The numerical value is the priority that this message
   * should be delivered (lower = more important) compared to other queued messages.
   * 
   * @author ajanata
   */
  public enum MessageType {
    PLAYER_EVENT(3), GAME_EVENT(3), GAME_PLAYER_EVENT(4), CHAT(5);

    private final int weight;

    MessageType(final int weight) {
      this.weight = weight;
    }

    public int getWeight() {
      return weight;
    }
  }
}
