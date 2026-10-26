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
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.TreeMap;
import java.util.WeakHashMap;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.common.collect.ImmutableSet;
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
  private static final Logger LOG = LogManager.getLogger(ChatFilter.class);

  private static final int DEFAULT_CHAT_FLOOD_MESSAGE_COUNT = 4;
  private static final int DEFAULT_CHAT_FLOOD_TIME_SECONDS = 30;
  private static final int DEFAULT_BASIC_MIN_MSG_LENGTH = 10;
  private static final double DEFAULT_BASIC_CHARACTER_RATIO = .5;
  private static final int DEFAULT_SPACES_MIN_MSG_LENGTH = 75;
  private static final int DEFAULT_SPACES_REQUIRED = 3;
  private static final int DEFAULT_CAPSLOCK_MIN_MSG_LENGTH = 50;
  private static final double DEFAULT_CAPSLOCK_RATIO = .5;
  private static final int DEFAULT_REPEATED_WORDS_MIN_COUNT = 10;
  private static final double DEFAULT_REPEATED_WORDS_UNIQUE_RATIO = .5;
  public static final String DEFAULT_SHADOWBAN_PROVIDER = DefaultShadowBannedStringsProvider.class
      .getCanonicalName();

  public static final Pattern SIMPLE_MESSAGE_PATTERN = Pattern
      .compile("^[a-zA-Z0-9 _\\-=+*()\\[\\]\\\\/|,.!\\?:'\"`~#]+$");

  private final Provider<Properties> propsProvider;
  private final Map<User, FilterData> filterData = Collections.synchronizedMap(new WeakHashMap<>());

  public enum Result {
    CAPSLOCK, DROP_MESSAGE, NO_MESSAGE, NOT_ENOUGH_SPACES, OK, REPEAT, REPEAT_WORDS, TOO_FAST, TOO_LONG, TOO_MANY_SPECIALS
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

    final long total = message.codePoints().count();

    if (!SIMPLE_MESSAGE_PATTERN.matcher(message).matches()
        && total >= getIntParameter(Scope.global, "basic_min_len", DEFAULT_BASIC_MIN_MSG_LENGTH)) {
      // do some more in-depth analysis. we don't want too many emoji or non-latin characters
      final long basic = message.codePoints()
          .filter(c -> Character.isJavaIdentifierPart(c) || Character.isSpaceChar(c))
          .count();
      if (((double) basic) / total < getDoubleParameter(Scope.global, "basic_ratio",
          DEFAULT_BASIC_CHARACTER_RATIO)) {
        return Result.TOO_MANY_SPECIALS;
      }
    }

    final String[] words = message.toLowerCase(Locale.ENGLISH).split("\\s+");
    final int spaces = words.length + 1;
    if (total >= getIntParameter(Scope.global, "spaces_min_len", DEFAULT_SPACES_MIN_MSG_LENGTH)
        && spaces < getIntParameter(Scope.global, "spaces_min_count", DEFAULT_SPACES_REQUIRED)) {
      return Result.NOT_ENOUGH_SPACES;
    }

    final Set<String> uniqueWords = ImmutableSet.copyOf(words);
    if (words.length >= getIntParameter(Scope.global, "repeated_words_min_count",
        DEFAULT_REPEATED_WORDS_MIN_COUNT)
        && ((double) uniqueWords.size()) / words.length < getDoubleParameter(Scope.global,
            "repeated_words_unique_ratio", DEFAULT_REPEATED_WORDS_UNIQUE_RATIO)) {
      return Result.REPEAT_WORDS;
    }

    final long caps = message.codePoints().filter(c -> Character.isUpperCase(c)).count();
    if (total >= getIntParameter(Scope.global, "capslock_min_len", DEFAULT_CAPSLOCK_MIN_MSG_LENGTH)
        && ((double) caps) / total > getDoubleParameter(Scope.global, "capslock_ratio",
            DEFAULT_CAPSLOCK_RATIO)) {
      return Result.CAPSLOCK;
    }

    getMessageTimes(user, Scope.global).add(System.currentTimeMillis());
    return Result.OK;
  }

  public Result filterGame(final User user, final String message) {
    final Result result = filterCommon(Scope.game, user, message);
    if (Result.OK != result) {
      return result;
    }

    getMessageTimes(user, Scope.game).add(System.currentTimeMillis());
    return Result.OK;
  }

  private Result filterCommon(final Scope scope, final User user, final String message) {
    final List<Long> messageTimes = getMessageTimes(user, scope);
    if (messageTimes.size() >= getFloodCount(scope)) {
      final Long head = messageTimes.get(0);
      if (System.currentTimeMillis() - head < getFloodTimeMillis(scope)) {
        return Result.TOO_FAST;
      }
      messageTimes.remove(0);
    }

    if (message.length() > Constants.CHAT_MAX_LENGTH) {
      return Result.TOO_LONG;
    } else if (message.length() == 0) {
      return Result.NO_MESSAGE;
    }

    final FilterData data = getFilterData(user);
    synchronized (data.lastMessages) {
      if (message.equals(data.lastMessages.get(scope))) {
        return Result.REPEAT;
      } else {
        data.lastMessages.put(scope, message);
      }
    }

    final String messageLower = message.toLowerCase(Locale.ENGLISH);
    // TODO keep track of how much someone does this and perma-shadowban them...
    for (final String banned : getShadowbanCharacters()) {
      // assume that the banned strings are already lowercase
      // check both ways in case it decides lowercase of some unicode is not what we want though
      if (message.contains(banned) || messageLower.contains(banned)) {
        LOG.info(String.format(
            "Dropping message '%s' from user %s (%s); contains banned string %s.", message,
            user.getNickname(), user.getHostname(), banned));
        return Result.DROP_MESSAGE;
      }
    }

    return Result.OK;
  }

  private int getIntParameter(final Scope scope, final String name, final int defaultValue) {
    try {
      return Integer.parseInt(getPropValue(
          String.format("pyx.chat.%s.%s", scope, name), String.valueOf(defaultValue)));
    } catch (final NumberFormatException e) {
      LOG.warn(String.format("Unable to parse pyx.chat.%s.%s as a number,"
          + " using default of %d", scope, name, defaultValue), e);
      return defaultValue;
    }
  }

  private double getDoubleParameter(final Scope scope, final String name,
      final double defaultValue) {
    try {
      return Double.parseDouble(
          getPropValue(String.format("pyx.chat.%s.%s", scope, name), String.valueOf(defaultValue)));
    } catch (final NumberFormatException e) {
      LOG.warn(String.format("Unable to parse pyx.chat.%s.%s as a number,"
          + " using default of %d", scope, name, defaultValue), e);
      return defaultValue;
    }
  }

  private Set<String> getShadowbanCharacters() {
    try {
      return ((ShadowBannedStringProvider) Class
          .forName(getPropValue("pyx.chat.shadowban_strings_provider",
          DEFAULT_SHADOWBAN_PROVIDER)).newInstance()).getShadowBannedStrings();
    } catch (final InstantiationException | IllegalAccessException | ClassNotFoundException
        | ClassCastException e) {
      LOG.error(String.format("Unable to load shadowban string provider %s, using empty set.",
          getPropValue("pyx.chat.shadowban_strings_provider", DEFAULT_SHADOWBAN_PROVIDER)),
          e);
      return Collections.emptySet();
    }
  }

  private String getPropValue(final String name, final String defaultValue) {
    return propsProvider.get().getProperty(name, defaultValue);
  }

  private int getFloodCount(final Scope scope) {
    return getIntParameter(scope, "flood_count", DEFAULT_CHAT_FLOOD_MESSAGE_COUNT);
  }

  private long getFloodTimeMillis(final Scope scope) {
    return TimeUnit.SECONDS
        .toMillis(getIntParameter(scope, "flood_time", DEFAULT_CHAT_FLOOD_TIME_SECONDS));
  }

  private FilterData getFilterData(final User user) {
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
    return data;
  }

  private List<Long> getMessageTimes(final User user, final Scope scope) {
    return getFilterData(user).lastMessageTimes.get(scope);
  }

  private static class FilterData {
    final Map<Scope, List<Long>> lastMessageTimes;
    final Map<Scope, String> lastMessages = Collections.synchronizedMap(new TreeMap<>());

    private FilterData() {
      final Map<Scope, List<Long>> map = new TreeMap<>();
      map.put(Scope.global, Collections.synchronizedList(new LinkedList<>()));
      map.put(Scope.game, Collections.synchronizedList(new LinkedList<>()));
      lastMessageTimes = Collections.unmodifiableMap(map);
    }
  }
}
