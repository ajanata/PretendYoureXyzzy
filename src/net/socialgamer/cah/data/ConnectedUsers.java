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

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import javax.annotation.Nullable;

import net.socialgamer.cah.Constants.DisconnectReason;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.LongPollEvent;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.data.QueuedMessage.MessageType;

import org.apache.log4j.Logger;

import com.google.inject.Singleton;


/**
 * Class that holds all users connected to the server, and provides functions to operate on said
 * list.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
@Singleton
public class ConnectedUsers {

  private static final Logger logger = Logger.getLogger(ConnectedUsers.class);

  /**
   * Duration of a ping timeout, in nanoseconds.
   */
  public static final long PING_TIMEOUT = TimeUnit.SECONDS.toNanos(45);

  /**
   * Key (username) must be stored in lower-case to facilitate case-insensitivity in nicks.
   */
  private final Map<String, User> users = new HashMap<String, User>();

  /**
   * @param userName
   *          User name to check.
   * @return True if {@code userName} is a connected user.
   */
  public boolean hasUser(final String userName) {
    return users.containsKey(userName.toLowerCase());
  }

  /**
   * Checks to see if the specified {@code user} is allowed to connect, and if so, add the user,
   * as an atomic operation.
   * @param user User to add. {@code getNickname()} is used to determine the nickname.
   * @param maxUsers Maximum number of users allowed to connect. Admins are always allowed to
   * connect.
   * @return {@code null} if the user was added, or an {@link ErrorCode} explaining why the user was
   * rejected.
   */
  public ErrorCode checkAndAdd(final User user, final int maxUsers) {
    synchronized (users) {
      if (this.hasUser(user.getNickname())) {
        logger.info(String.format("Rejecting existing username %s from %s", user.toString(),
            user.getHostName()));
        return ErrorCode.NICK_IN_USE;
      } else if (users.size() >= maxUsers && !user.isAdmin()) {
        logger.warn(String.format("Rejecting user %s due to too many users (%d >= %d)",
            user.toString(), users.size(), maxUsers));
        return ErrorCode.TOO_MANY_USERS;
      } else {
        logger.info(String.format("New user %s from %s (admin=%b)", user.toString(),
            user.getHostName(), user.isAdmin()));
        users.put(user.getNickname().toLowerCase(), user);
        final HashMap<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
        data.put(LongPollResponse.EVENT, LongPollEvent.NEW_PLAYER.toString());
        data.put(LongPollResponse.NICKNAME, user.getNickname());
        broadcastToAll(MessageType.PLAYER_EVENT, data);
        return null;
      }
    }
  }

  /**
   * Remove a user from the user list, and mark them as invalid so the next time they make a request
   * they can be informed.
   * 
   * @param user
   *          User to remove.
   * @param reason
   *          Reason the user is being removed.
   */
  public void removeUser(final User user, final DisconnectReason reason) {
    synchronized (users) {
      if (users.containsValue(user)) {
        logger.info(String.format("Removing user %s because %s", user.toString(), reason));
        user.noLongerVaild();
        users.remove(user.getNickname().toLowerCase());
        notifyRemoveUser(user, reason);
      }
    }
  }

  /**
   * Get the User for the specified nickname, or null if no such user exists.
   * 
   * @param nickname
   * @return User, or null.
   */
  @Nullable
  public User getUser(final String nickname) {
    return users.get(nickname.toLowerCase());
  }

  /**
   * Broadcast to all remaining users that a user has left.
   * 
   * @param user
   *          User that has left.
   * @param reason
   *          Reason why the user has left.
   */
  private void notifyRemoveUser(final User user, final DisconnectReason reason) {
    // Games are informed about the user leaving when the user object is marked invalid.
    final HashMap<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
    data.put(LongPollResponse.EVENT, LongPollEvent.PLAYER_LEAVE.toString());
    data.put(LongPollResponse.NICKNAME, user.getNickname());
    data.put(LongPollResponse.REASON, reason.toString());
    broadcastToAll(MessageType.PLAYER_EVENT, data);
  }

  /**
   * Check for any users that have not communicated with the server within the ping timeout delay,
   * and remove users which have not so communicated.
   */
  public void checkForPingTimeouts() {
    final Set<User> removedUsers = new HashSet<User>();
    synchronized (users) {
      final Iterator<User> iterator = users.values().iterator();
      while (iterator.hasNext()) {
        final User u = iterator.next();
        if (System.nanoTime() - u.getLastHeardFrom() > PING_TIMEOUT) {
          removedUsers.add(u);
          iterator.remove();
        }
      }
    }
    // Do this later to not keep users locked
    for (final User u : removedUsers) {
      try {
        u.noLongerVaild();
        notifyRemoveUser(u, DisconnectReason.PING_TIMEOUT);
      } catch (final Exception e) {
        logger.error("Unable to remove pinged-out user", e);
      }
    }
  }

  /**
   * Broadcast a message to all connected players.
   * 
   * @param type
   *          Type of message to broadcast. This determines the order the messages are returned by
   *          priority.
   * @param masterData
   *          Message data to broadcast.
   */
  public void broadcastToAll(final MessageType type,
      final HashMap<ReturnableData, Object> masterData) {
    broadcastToList(users.values(), type, masterData);
  }

  /**
   * Broadcast a message to a specified subset of connected players.
   * 
   * @param broadcastTo
   *          List of users to broadcast the message to.
   * @param type
   *          Type of message to broadcast. This determines the order the messages are returned by
   *          priority.
   * @param masterData
   *          Message data to broadcast.
   */
  public void broadcastToList(final Collection<User> broadcastTo, final MessageType type,
      final HashMap<ReturnableData, Object> masterData) {
    // TODO I think this synchronized block is pointless.
    synchronized (users) {
      for (final User u : broadcastTo) {
        @SuppressWarnings("unchecked")
        final Map<ReturnableData, Object> data = (Map<ReturnableData, Object>) masterData.clone();
        data.put(LongPollResponse.TIMESTAMP, System.currentTimeMillis());
        final QueuedMessage qm = new QueuedMessage(type, data);
        u.enqueueMessage(qm);
      }
    }
  }

  /**
   * @return A copy of the list of connected users.
   */
  public Collection<User> getUsers() {
    synchronized (users) {
      return new ArrayList<User>(users.values());
    }
  }
}
