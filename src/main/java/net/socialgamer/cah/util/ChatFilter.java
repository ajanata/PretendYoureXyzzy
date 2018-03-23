/**
 * Copyright (c) 2018, Andy Janata
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

package net.socialgamer.cah.util;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.TreeMap;
import java.util.WeakHashMap;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;

import net.socialgamer.cah.Constants;
import net.socialgamer.cah.data.User;


/**
 * Filter for chat messages. Currently handles flood limiting, can be extended with a lot more.
 */
@Singleton
public class ChatFilter {
  private static final Logger LOG = Logger.getLogger(ChatFilter.class);

  private static final int DEFAULT_CHAT_FLOOD_MESSAGE_COUNT = 4;
  private static final long DEFAULT_CHAT_FLOOD_TIME = TimeUnit.SECONDS.toMillis(30);

  private final Provider<Properties> propsProvider;
  private final Map<User, FilterData> filterData = Collections.synchronizedMap(new WeakHashMap<>());

  public enum Result {
    OK, TOO_FAST, TOO_LONG, NO_MESSAGE
  }

  private enum Scope {
    global, game
  }

  @Inject
  public ChatFilter(final Provider<Properties> propsProvider) {
    this.propsProvider = propsProvider;
  }

  public Result filterGlobal(final User user, final String message) {
    final Result result = filterCommon(Scope.global, user, message);
    if (Result.OK != result) {
      return result;
    }

    // TODO

    getMessageTimes(user, Scope.global).add(System.currentTimeMillis());
    return result;
  }

  public Result filterGame(final User user, final String message) {
    final Result result = filterCommon(Scope.game, user, message);
    if (Result.OK != result) {
      return result;
    }

    // TODO

    getMessageTimes(user, Scope.game).add(System.currentTimeMillis());
    return result;
  }

  private Result filterCommon(final Scope scope, final User user, final String message) {
    // TODO

    final List<Long> messageTimes = getMessageTimes(user, scope);
    if (messageTimes.size() >= getFloodCount(scope)) {
      final Long head = messageTimes.get(0);
      if (System.currentTimeMillis() - head < getFloodTime(scope)) {
        return Result.TOO_FAST;
      }
      messageTimes.remove(0);
    }

    if (message.length() > Constants.CHAT_MAX_LENGTH) {
      return Result.TOO_LONG;
    } else if (message.length() == 0) {
      return Result.NO_MESSAGE;
    }

    return Result.OK;
  }

  private int getFloodCount(final Scope scope) {
    try {
      return Integer.parseInt(propsProvider.get().getProperty(
          String.format("pyx.chat.%s.flood_count", scope),
          String.valueOf(DEFAULT_CHAT_FLOOD_MESSAGE_COUNT)));
    } catch (final NumberFormatException e) {
      LOG.warn(String.format("Unable to parse pyx.chat.%s.flood_count as a number,"
          + " using default of %d", scope, DEFAULT_CHAT_FLOOD_MESSAGE_COUNT), e);
      return DEFAULT_CHAT_FLOOD_MESSAGE_COUNT;
    }
  }

  private long getFloodTime(final Scope scope) {
    try {
      return TimeUnit.SECONDS.toMillis(Integer.parseInt(propsProvider.get().getProperty(
          String.format("pyx.chat.%s.flood_time", scope),
          String.valueOf(DEFAULT_CHAT_FLOOD_TIME))));
    } catch (final NumberFormatException e) {
      LOG.warn(String.format("Unable to parse pyx.chat.%s.flood_time as a number,"
          + " using default of %d", scope, DEFAULT_CHAT_FLOOD_TIME), e);
      return DEFAULT_CHAT_FLOOD_TIME;
    }
  }

  private List<Long> getMessageTimes(final User user, final Scope scope) {
    FilterData data;
    synchronized (filterData) {
      data = filterData.get(user);
      // we should only have to do this once per user...
      if (null == data) {
        LOG.trace(String.format("Created new FilterData for user %s", user.getNickname()));
        data = new FilterData();
        filterData.put(user, data);
      }
    }
    return data.lastMessageTimes.get(scope);
  }

  private static class FilterData {
    final Map<Scope, List<Long>> lastMessageTimes;

    private FilterData() {
      final Map<Scope, List<Long>> map = new TreeMap<>();
      map.put(Scope.global, Collections.synchronizedList(new LinkedList<>()));
      map.put(Scope.game, Collections.synchronizedList(new LinkedList<>()));
      lastMessageTimes = Collections.unmodifiableMap(map);
    }
  }
}
