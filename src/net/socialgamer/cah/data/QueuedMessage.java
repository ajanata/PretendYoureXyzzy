package net.socialgamer.cah.data;

import java.util.Map;

import net.socialgamer.cah.Constants.MessageType;


public class QueuedMessage implements Comparable<QueuedMessage> {

  private final MessageType messageType;
  private final Map<String, Object> data;

  public QueuedMessage(final MessageType messageType, final Map<String, Object> data) {
    this.messageType = messageType;
    this.data = data;
  }

  public MessageType getMessageType() {
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
}
