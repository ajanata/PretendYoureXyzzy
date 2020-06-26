/**
 * Copyright (c) 2012-2018, Andy Janata
 * All rights reserved.
 * <p>
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * <p>
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 * and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 * conditions and the following disclaimer in the documentation and/or other materials provided
 * with the distribution.
 * <p>
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package net.socialgamer.cah.customsets;

import com.dampcake.bencode.Bencode;
import com.google.common.base.Charsets;
import com.google.common.io.ByteSource;
import com.google.inject.Inject;
import com.google.inject.Provider;
import net.socialgamer.cah.CahModule;
import net.socialgamer.cah.CahModule.CustomDecksAllowedUrls;
import net.socialgamer.cah.CahModule.CustomDecksEnabled;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.io.IOException;
import java.io.InputStream;
import java.lang.ref.SoftReference;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Pattern;


public class CustomCardsService {
  private static final Logger LOG = Logger.getLogger(CustomCardsService.class);

  private static final int GET_TIMEOUT = (int) TimeUnit.SECONDS.toMillis(3);

  private static final LinkedList<SoftReference<CacheEntry>> cache = new LinkedList<SoftReference<CacheEntry>>();

  private static final Pattern VALID_WATERMARK_PATTERN = Pattern.compile("[A-Z0-9]{5}");

  /**
   * How long to cache nonexistent card sets, or after an error occurs while querying for the card
   * set. We need to do this to prevent DoS attacks.
   */
  private static final long INVALID_SET_CACHE_LIFETIME = TimeUnit.SECONDS.toMillis(30);

  /**
   * How long to cache valid card sets.
   */
  private static final long VALID_SET_CACHE_LIFETIME = TimeUnit.MINUTES.toMillis(15);

  private static final AtomicInteger cardIdCounter = new AtomicInteger(Integer.MIN_VALUE);
  private static final AtomicInteger deckIdCounter = new AtomicInteger(0);

  private final Bencode bencode = new Bencode();
  private final Provider<Boolean> enabledProvider;
  private final Provider<List<String>> allowedUrlsProvider;

  @Inject
  public CustomCardsService(@CustomDecksEnabled Provider<Boolean> enabledProvider, @CustomDecksAllowedUrls Provider<List<String>> allowedUrlsProvider) {
    this.enabledProvider = enabledProvider;
    this.allowedUrlsProvider = allowedUrlsProvider;
  }

  public static void hackSslVerifier() {
    // TODO: Nothing to hack?
  }

  private static boolean checkCacheValid(CacheEntry entry, String method, String key) {
    if (null != entry && entry.expires > System.currentTimeMillis()) {
      LOG.info(String.format("Using cache (%s): %s=%s", method, key, entry.deck));
      return true;
    } else if (null != entry) {
      LOG.info(String.format("Cache stale (%s): %s", method, key));
      return false;
    } else {
      LOG.info(String.format("Cache miss (%s): %s", method, key));
      return false;
    }
  }

  public CustomDeck loadSet(int customDeckId) {
    if (!enabledProvider.get())
      return null;

    CacheEntry entry = checkCacheId(customDeckId);
    if (checkCacheValid(entry, "id", String.valueOf(customDeckId))) return entry.deck;
    else return null;
  }

  public CustomDeck loadSetFromUrl(String url) {
    if (!enabledProvider.get())
      return null;

    CacheEntry entry = checkCacheUrl(url);
    if (checkCacheValid(entry, "url", url))
      return entry.deck;

    try {
      String content = getUrlContent(url);
      if (content == null) {
        putCache(null, INVALID_SET_CACHE_LIFETIME, url, null);
        return null;
      }

      return loadSetFromJson(content, url);
    } catch (IOException e) {
      putCache(null, INVALID_SET_CACHE_LIFETIME, url, null);
      LOG.error(String.format("Unable to load deck from %s", url), e);
      e.printStackTrace();
      return null;
    }
  }

  public CustomDeck loadSetFromJson(String jsonStr, String url) {
    if (!enabledProvider.get())
      return null;

    JSONObject obj;
    String hash;
    try {
      obj = (JSONObject) JSONValue.parse(jsonStr);
      hash = DigestUtils.md5Hex(bencode.encode(obj));
    } catch (Exception e) {
      putCache(null, INVALID_SET_CACHE_LIFETIME, url, null);
      LOG.error("Unable to parse deck.", e);
      e.printStackTrace();
      return null;
    }

    CacheEntry entry = checkCacheHash(hash);
    if (checkCacheValid(entry, "json", hash))
      return entry.deck;

    try {
      final String name = (String) obj.get("name");
      final String description = (String) obj.get("description");
      final String watermark = (String) obj.get("watermark");
      if (null == name || null == description || name.isEmpty() || watermark == null || !VALID_WATERMARK_PATTERN.matcher(watermark).matches()) {
        // We require a name. Blank description is acceptable, but cannot be null. Watermark is required and must respect the pattern.
        return null;
      }

      int deckId = deckIdCounter.decrementAndGet();
      final CustomDeck deck = new CustomDeck(deckId, StringEscapeUtils.escapeXml11(name), StringEscapeUtils.escapeXml11(watermark), StringEscapeUtils.escapeXml11(description));

      // load up the cards
      final JSONArray blacks = (JSONArray) obj.get("calls");
      if (null != blacks) {
        for (final Object black : blacks) {
          final JSONArray texts = (JSONArray) ((JSONObject) black).get("text");
          if (null != texts) {
            final String text = CustomCardFormatHelper.formatBlackCard(texts);
            final int pick = texts.size() - 1;
            final int draw = (pick >= 3 ? pick - 1 : 0);
            final CustomBlackCard card = new CustomBlackCard(cardIdCounter.incrementAndGet(), text, draw, pick, watermark);
            deck.getBlackCards().add(card);
          }
        }
      }

      final JSONArray whites = (JSONArray) obj.get("responses");
      if (null != whites) {
        for (final Object white : whites) {
          final JSONArray texts = (JSONArray) ((JSONObject) white).get("text");
          if (null != texts) {
            final String text = CustomCardFormatHelper.formatWhiteCard(texts);
            // don't add blank cards, they don't do anything
            if (!text.isEmpty()) {
              final CustomWhiteCard card = new CustomWhiteCard(cardIdCounter.incrementAndGet(), text, watermark);
              deck.getWhiteCards().add(card);
            }
          }
        }
      }

      putCache(deck, VALID_SET_CACHE_LIFETIME, url, hash);
      return deck;
    } catch (Exception e) {
      putCache(null, INVALID_SET_CACHE_LIFETIME, url, hash);
      LOG.error("Unable to load deck.", e);
      e.printStackTrace();
      return null;
    }
  }

  private CacheEntry checkCacheId(int id) {
    synchronized (cache) {
      ListIterator<SoftReference<CacheEntry>> iterator = cache.listIterator();
      while (iterator.hasNext()) {
        CacheEntry entry = iterator.next().get();
        if (entry == null) {
          iterator.remove();
          continue;
        }

        if (entry.deck != null && entry.deck.getId() == id)
          return entry;
      }

      return null;
    }
  }

  private CacheEntry checkCacheUrl(String url) {
    synchronized (cache) {
      ListIterator<SoftReference<CacheEntry>> iterator = cache.listIterator();
      while (iterator.hasNext()) {
        CacheEntry entry = iterator.next().get();
        if (entry == null) {
          iterator.remove();
          continue;
        }

        if (url.equals(entry.url))
          return entry;
      }

      return null;
    }
  }

  private CacheEntry checkCacheHash(String hash) {
    synchronized (cache) {
      ListIterator<SoftReference<CacheEntry>> iterator = cache.listIterator();
      while (iterator.hasNext()) {
        CacheEntry entry = iterator.next().get();
        if (entry == null) {
          iterator.remove();
          continue;
        }

        if (hash.equals(entry.hash))
          return entry;
      }

      return null;
    }
  }

  private void putCache(CustomDeck deck, long timeout, String url, String hash) {
    synchronized (cache) {
      cache.add(new SoftReference<>(new CacheEntry(timeout + System.currentTimeMillis(), deck, url, hash)));
    }
  }

  private String getUrlContent(final String urlStr) throws IOException {
    final URL url = new URL(urlStr);

    List<String> allowedUrls = allowedUrlsProvider.get();
    boolean allowed = false;
    for (String pattern : allowedUrls) {
      if ("*".equals(pattern)) {
        allowed = true;
      } else if (pattern.charAt(0) == '*') {
        allowed = url.getHost().endsWith(pattern.substring(1));
      } else {
        allowed = url.getHost().equals(pattern);
      }

      if (allowed)
        break;
    }

    if (!allowed) {
      LOG.info("Cannot load deck, domain is not allowed: " + url.getHost());
      return null;
    }

    final HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setDoInput(true);
    conn.setDoOutput(false);
    conn.setRequestMethod("GET");
    conn.setInstanceFollowRedirects(true);
    conn.setReadTimeout(GET_TIMEOUT);
    conn.setConnectTimeout(GET_TIMEOUT);

    final int code = conn.getResponseCode();
    if (HttpURLConnection.HTTP_OK != code) {
      LOG.error(String.format("Got HTTP response code %d for %s", code, urlStr));
      return null;
    }
    final String contentType = conn.getContentType();
    if (contentType == null || !contentType.startsWith("application/json")) {
      LOG.error(String.format("Got content-type %s for %s", contentType, urlStr));
      return null;
    }

    try (InputStream is = conn.getInputStream()) {
      return new ByteSource() {
        @Override
        public InputStream openStream() {
          return is;
        }
      }.asCharSource(Charsets.UTF_8).read();
    }
  }

  private static class CacheEntry {
    final long expires;
    final CustomDeck deck;
    final String url;
    final String hash;

    CacheEntry(long expires, CustomDeck deck, String url, String hash) {
      this.expires = expires;
      this.deck = deck;
      this.url = url;
      this.hash = hash;
    }
  }
}
