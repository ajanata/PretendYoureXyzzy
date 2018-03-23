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

import java.util.Properties;
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

  public enum Result {
    OK, TOO_FAST, TOO_LONG, NO_MESSAGE
  }

  @Inject
  public ChatFilter(final Provider<Properties> propsProvider) {
    this.propsProvider = propsProvider;
  }

  public Result filterGlobal(final User user, final String message) {
    final Result result = filterCommon(user, message);
    if (Result.OK != result) {
      return result;
    }

    // TODO
    user.getLastMessageTimes().add(System.currentTimeMillis());
    return result;
  }

  public Result filterGame(final User user, final String message) {
    final Result result = filterCommon(user, message);
    if (Result.OK != result) {
      return result;
    }

    // TODO
    user.getLastMessageTimes().add(System.currentTimeMillis());
    return result;
  }

  private Result filterCommon(final User user, final String message) {
    // TODO

    // Intentionally leaving flood protection as per-user, rather than
    // changing it to per-user-per-game.
    if (user.getLastMessageTimes().size() >= getFloodCount()) {
      final Long head = user.getLastMessageTimes().get(0);
      if (System.currentTimeMillis() - head < getFloodTime()) {
        return Result.TOO_FAST;
      }
      user.getLastMessageTimes().remove(0);
    }

    if (message.length() > Constants.CHAT_MAX_LENGTH) {
      return Result.TOO_LONG;
    } else if (message.length() == 0) {
      return Result.NO_MESSAGE;
    }

    return Result.OK;
  }

  private int getFloodCount() {
    try {
      return Integer.parseInt(propsProvider.get().getProperty("pyx.chat.flood_count",
          String.valueOf(DEFAULT_CHAT_FLOOD_MESSAGE_COUNT)));
    } catch (final NumberFormatException e) {
      LOG.warn(String.format("Unable to parse pyx.chat.flood_count as a number,"
          + " using default of %d", DEFAULT_CHAT_FLOOD_MESSAGE_COUNT), e);
      return DEFAULT_CHAT_FLOOD_MESSAGE_COUNT;
    }
  }

  private long getFloodTime() {
    try {
      return TimeUnit.SECONDS.toMillis(Integer.parseInt(propsProvider.get().getProperty(
          "pyx.chat.flood_time", String.valueOf(DEFAULT_CHAT_FLOOD_TIME))));
    } catch (final NumberFormatException e) {
      LOG.warn(String.format("Unable to parse pyx.chat.flood_time as a number,"
          + " using default of %d", DEFAULT_CHAT_FLOOD_TIME), e);
      return DEFAULT_CHAT_FLOOD_TIME;
    }
  }
}
