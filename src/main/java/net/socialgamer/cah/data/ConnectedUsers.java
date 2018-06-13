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

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import javax.annotation.Nullable;

import org.apache.log4j.Logger;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;
import com.maxmind.geoip2.model.CityResponse;

import net.socialgamer.cah.CahModule.BroadcastConnectsAndDisconnects;
import net.socialgamer.cah.CahModule.MaxUsers;
import net.socialgamer.cah.Constants.DisconnectReason;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.LongPollEvent;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.data.QueuedMessage.MessageType;
import net.socialgamer.cah.metrics.GeoIP;
import net.socialgamer.cah.metrics.Metrics;


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
  public static final long PING_TIMEOUT = TimeUnit.SECONDS.toNanos(90);

  /**
   * Duration of an idle timeout, in nanoseconds.
   */
  public static final long IDLE_TIMEOUT = TimeUnit.MINUTES.toNanos(60);

  /**
   * Key (username) must be stored in lower-case to facilitate case-insensitivity in nicks.
   */
  private final Map<String, User> users = Collections.synchronizedMap(new HashMap<>());

  final Provider<Boolean> broadcastConnectsAndDisconnectsProvider;
  final Provider<Integer> maxUsersProvider;
  final GeoIP geoIp;
  final Metrics metrics;

  @Inject
  public ConnectedUsers(
      @BroadcastConnectsAndDisconnects final Provider<Boolean> broadcastConnectsAndDisconnectsProvider,
      @MaxUsers final Provider<Integer> maxUsersProvider, final GeoIP geoIp,
      final Metrics metrics) {
    this.broadcastConnectsAndDisconnectsProvider = broadcastConnectsAndDisconnectsProvider;
    this.maxUsersProvider = maxUsersProvider;
    this.geoIp = geoIp;
    this.metrics = metrics;
  }

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
   * @return {@code null} if the user was added, or an {@link ErrorCode} explaining why the user was
   * rejected.
   */
  public ErrorCode checkAndAdd(final User user) {
    final int maxUsers = maxUsersProvider.get();
    synchronized (users) {
      if (this.hasUser(user.getNickname())) {
        logger.info(String.format("Rejecting existing username %s from %s", user.toString(),
            user.getHostname()));
        return ErrorCode.NICK_IN_USE;
      } else if (users.size() >= maxUsers && !user.isAdmin()) {
        logger.warn(String.format("Rejecting user %s due to too many users (%d >= %d)",
            user.toString(), users.size(), maxUsers));
        return ErrorCode.TOO_MANY_USERS;
      } else {
        logger.info(String.format("New user %s from %s (admin=%b, id=%s)", user.toString(),
            user.getHostname(), user.isAdmin(), user.getIdCode()));
        users.put(user.getNickname().toLowerCase(), user);
        final HashMap<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
        data.put(LongPollResponse.EVENT, LongPollEvent.NEW_PLAYER.toString());
        data.put(LongPollResponse.NICKNAME, user.getNickname());
        data.put(LongPollResponse.SIGIL, user.getSigil().toString());
        data.put(LongPollResponse.ID_CODE, user.getIdCode());
        if (broadcastConnectsAndDisconnectsProvider.get()) {
          broadcastToAll(MessageType.PLAYER_EVENT, data);
        } else {
          broadcastToList(getAdmins(), MessageType.PLAYER_EVENT, data);
        }
        // log them in the metrics
        CityResponse geo = null;
        try {
          final InetAddress addr = InetAddress.getByName(user.getHostname());
          geo = geoIp.getInfo(addr);
        } catch (final UnknownHostException e) {
          logger.warn(String.format("Unable to get address for user %s (hostname: %s)",
              user.getNickname(), user.getHostname()), e);
        }
        metrics.userConnect(user.getPersistentId(), user.getSessionId(), geo, user.getAgentName(),
            user.getAgentType(), user.getAgentOs(), user.getAgentLanguage());

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
      if (users.containsKey(user.getNickname().toLowerCase())) {
        logger.info(String.format("Removing user %s because %s", user.toString(), reason));
        user.noLongerValid();
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
   * Broadcast to all remaining users that a user has left. Also logs for metrics.
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
    if (broadcastConnectsAndDisconnectsProvider.get() || reason == DisconnectReason.BANNED
        || reason == DisconnectReason.KICKED) {
      broadcastToAll(MessageType.PLAYER_EVENT, data);
    } else {
      // always tell admins
      broadcastToList(getAdmins(), MessageType.PLAYER_EVENT, data);
    }

    metrics.userDisconnect(user.getSessionId());
  }

  /**
   * Check for any users that have not communicated with the server within the ping timeout delay,
   * and remove users which have not so communicated. Also remove clients which are still connected,
   * but have not actually done anything for a long time.
   */
  public void checkForPingAndIdleTimeouts() {
    final Map<User, DisconnectReason> removedUsers = new HashMap<User, DisconnectReason>();
    synchronized (users) {
      final Iterator<User> iterator = users.values().iterator();
      while (iterator.hasNext()) {
        final User u = iterator.next();
        DisconnectReason reason = null;
        if (System.nanoTime() - u.getLastHeardFrom() > PING_TIMEOUT) {
          reason = DisconnectReason.PING_TIMEOUT;
        }
        else if (!u.isAdmin() && System.nanoTime() - u.getLastUserAction() > IDLE_TIMEOUT) {
          reason = DisconnectReason.IDLE_TIMEOUT;
        }
        if (null != reason) {
          removedUsers.put(u, reason);
          iterator.remove();
        }
      }
    }
    // Do this later to not keep users locked
    for (final Entry<User, DisconnectReason> entry : removedUsers.entrySet()) {
      try {
        entry.getKey().noLongerValid();
        notifyRemoveUser(entry.getKey(), entry.getValue());
        logger.info(String.format("Automatically kicking user %s due to %s", entry.getKey(),
            entry.getValue()));
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

  /**
   * @return A copy of the list of connected users, filtered to contain only administrators.
   */
  public Collection<User> getAdmins() {
    synchronized (users) {
      return users.values().stream().filter(u -> u.isAdmin()).collect(Collectors.toSet());
    }
  }
}
