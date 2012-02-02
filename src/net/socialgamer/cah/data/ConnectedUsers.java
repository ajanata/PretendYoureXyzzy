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
import java.util.Iterator;
import java.util.Map;

import net.socialgamer.cah.Constants.DisconnectReason;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.data.QueuedMessage.MessageType;

import com.google.inject.Singleton;
import com.sun.istack.internal.Nullable;


/**
 * Class that holds all users connected to the server, and provides functions to operate on said
 * list.
 * 
 * @author ajanata
 */
@Singleton
public class ConnectedUsers {

  /**
   * Duration of a ping timeout, in nanoseconds.
   */
  public static final long PING_TIMEOUT = 3L * 60L * 1000L * 1000000L;
  //  public static final long PING_TIMEOUT = 30L * 1000L * 1000000L;

  private final Map<String, User> users = new HashMap<String, User>();

  public boolean hasUser(final String userName) {
    return users.containsKey(userName);
  }

  public void newUser(final User user) {
    synchronized (users) {
      users.put(user.getNickname(), user);
      final HashMap<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
      data.put(LongPollResponse.EVENT, "new_player");
      data.put(LongPollResponse.NICKNAME, user.getNickname());
      broadcastToAll(MessageType.PLAYER_EVENT, data);
    }
  }

  public void removeUser(final User user, final DisconnectReason reason) {
    synchronized (users) {
      if (users.containsValue(user)) {
        user.noLongerVaild();
        users.remove(user.getNickname());
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
    return users.get(nickname);
  }

  private void notifyRemoveUser(final User user, final DisconnectReason reason) {
    // We might also have to tell games about this directly, probably with a listener system.
    final HashMap<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
    data.put(LongPollResponse.EVENT, "player_leave");
    data.put(LongPollResponse.NICKNAME, user.getNickname());
    data.put(LongPollResponse.REASON, reason.toString());
    broadcastToAll(MessageType.PLAYER_EVENT, data);
  }

  public void checkForPingTimeouts() {
    synchronized (users) {
      final Iterator<User> iterator = users.values().iterator();
      while (iterator.hasNext()) {
        final User u = iterator.next();
        if (System.nanoTime() - u.getLastHeardFrom() > PING_TIMEOUT) {
          u.noLongerVaild();
          notifyRemoveUser(u, DisconnectReason.PING_TIMEOUT);
          iterator.remove();
        }
      }
    }
  }

  /**
   * Broadcast a message to all connected players.
   * 
   * @param type
   * @param masterData
   */
  public void broadcastToAll(final MessageType type,
      final HashMap<ReturnableData, Object> masterData) {
    broadcastToList(users.values(), type, masterData);
  }

  /**
   * Broadcast a message to a specified subset of connected players.
   * 
   * @param broadcastTo
   * @param type
   * @param masterData
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

  public Collection<User> getUsers() {
    // return a copy
    synchronized (users) {
      return new ArrayList<User>(users.values());
    }
  }
}
