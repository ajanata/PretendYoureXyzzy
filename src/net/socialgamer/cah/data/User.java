package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.Collection;
import java.util.concurrent.PriorityBlockingQueue;


public class User {

  public enum DisconnectReason {
    MANUAL, PING_TIMEOUT, KICKED
  }

  private final String nickname;

  private final PriorityBlockingQueue<QueuedMessage> queuedMessages;

  private final Object queuedMessageSynchronization = new Object();

  private long lastHeardFrom = 0;

  public User(final String nickname) {
    this.nickname = nickname;
    queuedMessages = new PriorityBlockingQueue<QueuedMessage>();
  }

  public void enqueueMessage(final QueuedMessage message) {
    synchronized (queuedMessageSynchronization) {
      queuedMessages.add(message);
      queuedMessageSynchronization.notifyAll();
    }
  }

  public boolean hasQueuedMessages() {
    return !queuedMessages.isEmpty();
  }

  /**
   * Wait for a new message to be queued.
   * 
   * @see java.lang.Object#wait(long timeout)
   * @param timeout
   *          Maximum time to wait in milliseconds.
   * @throws InterruptedException
   */
  public void waitForNewMessageNotification(final long timeout) throws InterruptedException {
    synchronized (queuedMessageSynchronization) {
      queuedMessageSynchronization.wait(timeout);
    }
  }

  /**
   * This method blocks if there are no messages to return, or perhaps if the queue is being
   * modified by another thread.
   * 
   * @return The next message in the queue, or null if interrupted.
   */
  public QueuedMessage getNextQueuedMessage() {
    try {
      return queuedMessages.take();
    } catch (final InterruptedException ie) {
      return null;
    }
  }

  public Collection<QueuedMessage> getNextQueuedMessages(final int maxElements) {
    final ArrayList<QueuedMessage> c = new ArrayList<QueuedMessage>(maxElements);
    synchronized (queuedMessageSynchronization) {
      queuedMessages.drainTo(c, maxElements);
    }
    c.trimToSize();
    return c;
  }

  public String getNickname() {
    return nickname;
  }

  /**
   * Update the timestamp that we have last heard from this user to the current time.
   */
  public void contactedServer() {
    lastHeardFrom = System.nanoTime();
  }

  /**
   * @return The time the user was last heard from, in nanoseconds.
   */
  public long getLastHeardFrom() {
    return lastHeardFrom;
  }

}
