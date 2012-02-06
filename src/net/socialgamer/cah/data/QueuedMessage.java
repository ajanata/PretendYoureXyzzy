/**
 * Copyright (c) 2012, Andy Janata
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * 
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 *   and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 *   conditions and the following disclaimer in the documentation and/or other materials provided
 *   with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package net.socialgamer.cah.data;

import java.util.Map;

import net.socialgamer.cah.Constants.ReturnableData;


/**
 * A message to be queued for delivery to a client.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class QueuedMessage implements Comparable<QueuedMessage> {

  private final MessageType messageType;
  private final Map<ReturnableData, Object> data;

  /**
   * Create a new queued message.
   * 
   * @param messageType
   *          Type of message to be queued. The type influences the priority in returning messages
   *          to the client.
   * @param data
   *          The data of the message to be queued.
   */
  public QueuedMessage(final MessageType messageType, final Map<ReturnableData, Object> data) {
    this.messageType = messageType;
    this.data = data;
  }

  /**
   * @return The type of the message.
   */
  public MessageType getMessageType() {
    return messageType;
  }

  /**
   * @return The data in the message.
   */
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
   */
  public enum MessageType {
    KICKED(1), PLAYER_EVENT(3), GAME_EVENT(3), GAME_PLAYER_EVENT(4), CHAT(5);

    private final int weight;

    MessageType(final int weight) {
      this.weight = weight;
    }

    public int getWeight() {
      return weight;
    }
  }
}
