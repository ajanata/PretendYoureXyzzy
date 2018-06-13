/**
 * Copyright (c) 2012-2018, Andy Janata
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

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.concurrent.PriorityBlockingQueue;

import javax.annotation.Nullable;

import org.apache.log4j.Logger;

import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;

import net.sf.uadetector.ReadableUserAgent;
import net.sf.uadetector.service.UADetectorServiceFactory;
import net.socialgamer.cah.CahModule.UniqueId;
import net.socialgamer.cah.Constants.Sigil;


/**
 * A user connected to the server.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class User {

  private static final Logger LOG = Logger.getLogger(User.class);

  private final String nickname;

  private final String idCode;

  private final PriorityBlockingQueue<QueuedMessage> queuedMessages;

  private final Object queuedMessageSynchronization = new Object();

  private long lastHeardFrom = 0;

  private long lastUserAction = 0;

  private final long connectedAt = new Date().getTime();

  private Game currentGame;

  private final String hostname;

  private final boolean isAdmin;

  private final String persistentId;

  private final String sessionId;

  private final String clientLanguage;

  private final ReadableUserAgent agent;

  /**
   * Reset when this user object is no longer valid, most likely because it pinged out.
   */
  private boolean valid = true;

  /**
   * Create a new user.
   *
   * @param nickname
   *          The user's nickname.
   * @param idCode
   *          The user's ID code, after hashing with salt and their name, or the empty string if
   *          none provided.
   * @param hostname
   *          The user's Internet hostname (which will likely just be their IP address).
   * @param isAdmin
   *          Whether this user is an admin.
   * @param persistentId
   *          This user's persistent (cross-session) ID.
   * @param sessionId
   *          The unique ID of this session for this server instance.
   * @param clientLanguage
   *          The language of the user's web browser/client.
   * @param clientAgent
   *          The name of the user's web browser/client.
   */
  @Inject
  public User(@Assisted("nickname") final String nickname,
      @Assisted("idCode") final String idCode,
      @Assisted("hostname") final String hostname,
      @Assisted final boolean isAdmin,
      @Assisted("persistentId") final String persistentId,
      @UniqueId final String sessionId,
      @Nullable @Assisted("clientLanguage") final String clientLanguage,
      @Nullable @Assisted("clientAgent") final String clientAgent) {
    this.nickname = nickname;
    this.idCode = idCode;
    this.hostname = hostname;
    this.isAdmin = isAdmin;
    this.persistentId = persistentId;
    this.sessionId = sessionId;
    this.clientLanguage = clientLanguage == null ? "" : clientLanguage;
    agent = UADetectorServiceFactory.getResourceModuleParser().parse(clientAgent);
    queuedMessages = new PriorityBlockingQueue<QueuedMessage>();
  }

  public interface Factory {
    User create(@Assisted("nickname") String nickname, @Assisted("idCode") String idCode,
        @Assisted("hostname") String hostname, boolean isAdmin,
        @Assisted("persistentId") String persistentId,
        @Nullable @Assisted("clientLanguage") String clientLanguage,
        @Nullable @Assisted("clientAgent") String clientAgent);
  }

  /**
   * Enqueue a new message to be delivered to the user.
   *
   * @param message
   *          Message to enqueue.
   */
  public void enqueueMessage(final QueuedMessage message) {
    synchronized (queuedMessageSynchronization) {
      queuedMessages.add(message);
      queuedMessageSynchronization.notifyAll();
    }
  }

  /**
   * @return True if the user has any messages queued to be delivered.
   */
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
    if (timeout > 0) {
      synchronized (queuedMessageSynchronization) {
        queuedMessageSynchronization.wait(timeout);
      }
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

  /**
   * @param maxElements
   *          Maximum number of messages to return.
   * @return The next {@code maxElements} messages queued for this user.
   */
  public Collection<QueuedMessage> getNextQueuedMessages(final int maxElements) {
    final ArrayList<QueuedMessage> c = new ArrayList<QueuedMessage>(maxElements);
    synchronized (queuedMessageSynchronization) {
      queuedMessages.drainTo(c, maxElements);
    }
    c.trimToSize();
    return c;
  }

  public boolean isAdmin() {
    return isAdmin;
  }

  public String getIdCode() {
    return idCode;
  }

  public Sigil getSigil() {
    if (isAdmin) {
      return Sigil.ADMIN;
    } else if (!idCode.isEmpty()) {
      return Sigil.ID_CODE;
    } else {
      return Sigil.NORMAL_USER;
    }
  }

  public String getSessionId() {
    return sessionId;
  }

  public String getPersistentId() {
    return persistentId;
  }

  /**
   * @return The user's nickname.
   */
  public String getNickname() {
    return nickname;
  }

  /**
   * @return The user's Internet hostname, or IP address.
   */
  public String getHostname() {
    return hostname;
  }

  public String getAgentName() {
    return agent.getName();
  }

  public String getAgentType() {
    return agent.getDeviceCategory().getName();
  }

  public String getAgentOs() {
    return agent.getOperatingSystem().getName();
  }

  public String getAgentLanguage() {
    return clientLanguage.split(",")[0];
  }

  @Override
  public String toString() {
    return getNickname();
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

  public void userDidSomething() {
    lastUserAction = System.nanoTime();
  }

  public long getLastUserAction() {
    return lastUserAction;
  }

  /**
   * @return The UNIX timestamp at which this user connected, in milliseconds.
   */
  public long getConnectedAt() {
    return connectedAt;
  }

  /**
   * @return False when this user object is no longer valid, probably because it pinged out.
   */
  public boolean isValid() {
    return valid;
  }

  public boolean isValidFromHost(final String currentHostname) {
    final boolean addrValid = hostname.equals(currentHostname);
    if (!addrValid) {
      LOG.warn(String.format("User %s used to be from %s but is now from %s", nickname, hostname,
          currentHostname));
    }
    return isValid() && addrValid;
  }

  /**
   * Mark this user as no longer valid, probably because they pinged out.
   */
  public void noLongerValid() {
    if (currentGame != null) {
      final Game game = currentGame;
      game.removePlayer(this);
      game.removeSpectator(this);
    }
    valid = false;
  }

  /**
   * @return The current game in which this user is participating.
   */
  public Game getGame() {
    return currentGame;
  }

  /**
   * Marks a given game as this user's active game.
   *
   * This should only be called from Game itself.
   *
   * @param game
   *          Game in which this user is playing.
   * @throws IllegalStateException
   *           Thrown if this user is already in another game.
   */
  void joinGame(final Game game) throws IllegalStateException {
    if (currentGame != null) {
      throw new IllegalStateException("User is already in a game.");
    }
    currentGame = game;
  }

  /**
   * Marks the user as no longer participating in a game.
   *
   * This should only be called from Game itself.
   *
   * @param game
   *          Game from which to remove the user.
   */
  void leaveGame(final Game game) {
    if (currentGame == game) {
      currentGame = null;
    }
  }
}
