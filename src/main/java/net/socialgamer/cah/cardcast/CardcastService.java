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

package net.socialgamer.cah.cardcast;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.ref.SoftReference;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.cert.X509Certificate;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.google.inject.Inject;
import com.google.inject.Provider;

import net.socialgamer.cah.cardcast.CardcastModule.CardcastCardId;


public class CardcastService {
  private static final Logger LOG = Logger.getLogger(CardcastService.class);

  private static final String HOSTNAME = "api.cardcastgame.com";

  /**
   * Base URL to the Cardcast API.
   */
  private static final String BASE_URL = "https://" + HOSTNAME + "/v1/decks/";
  /**
   * URL to the Cardcast API for information about a card set. The only format replacement is the
   * string deck ID.
   */
  private static final String CARD_SET_INFO_URL_FORMAT_STRING = BASE_URL + "%s";
  /**
   * URL to the Cardcast API for cards in a card set. The only format replacement is the string
   * deck ID.
   */
  private static final String CARD_SET_CARDS_URL_FORMAT_STRING = CARD_SET_INFO_URL_FORMAT_STRING
      + "/cards";

  private static final int GET_TIMEOUT = (int) TimeUnit.SECONDS.toMillis(3);

  /**
   * How long to cache nonexistent card sets, or after an error occurs while querying for the card
   * set. We need to do this to prevent DoS attacks.
   */
  private static final long INVALID_SET_CACHE_LIFETIME = TimeUnit.SECONDS.toMillis(30);

  /**
   * How long to cache valid card sets.
   */
  private static final long VALID_SET_CACHE_LIFETIME = TimeUnit.MINUTES.toMillis(15);

  private static final Pattern validIdPattern = Pattern.compile("[A-Z0-9]{5}");

  private static final Map<String, SoftReference<CardcastCacheEntry>> cache = Collections
      .synchronizedMap(new HashMap<String, SoftReference<CardcastCacheEntry>>());

  private final Provider<Integer> cardIdProvider;
  private final CardcastFormatHelper formatHelper;

  @Inject
  public CardcastService(@CardcastCardId final Provider<Integer> cardIdProvider,
      final CardcastFormatHelper formatHelper) {
    this.cardIdProvider = cardIdProvider;
    this.formatHelper = formatHelper;
  }

  private class CardcastCacheEntry {
    final long expires;
    final CardcastDeck deck;

    CardcastCacheEntry(final long cacheLifetime, final CardcastDeck deck) {
      this.expires = System.currentTimeMillis() + cacheLifetime;
      this.deck = deck;
    }
  }

  private CardcastCacheEntry checkCache(final String setId) {
    final SoftReference<CardcastCacheEntry> soft = cache.get(setId);
    if (null == soft) {
      return null;
    }
    return soft.get();
  }

  public CardcastDeck loadSet(final String setId) {
    if (!validIdPattern.matcher(setId).matches()) {
      return null;
    }
    final CardcastCacheEntry cached = checkCache(setId);
    if (null != cached && cached.expires > System.currentTimeMillis()) {
      LOG.info(String.format("Using cache: %s=%s", setId, cached.deck));
      return cached.deck;
    } else if (null != cached) {
      LOG.info(String.format("Cache stale: %s", setId));
    } else {
      LOG.info(String.format("Cache miss: %s", setId));
    }

    try {
      final String infoContent = getUrlContent(String
          .format(CARD_SET_INFO_URL_FORMAT_STRING, setId));
      if (null == infoContent) {
        // failed to load
        cacheMissingSet(setId);
        return null;
      }
      final JSONObject info = (JSONObject) JSONValue.parse(infoContent);

      final String cardContent = getUrlContent(String.format(
          CARD_SET_CARDS_URL_FORMAT_STRING, setId));
      if (null == cardContent) {
        // failed to load
        cacheMissingSet(setId);
        return null;
      }
      final JSONObject cards = (JSONObject) JSONValue.parse(cardContent);

      final String name = (String) info.get("name");
      final String description = (String) info.get("description");
      if (null == name || null == description || name.isEmpty()) {
        // We require a name. Blank description is acceptable, but cannot be null.
        cacheMissingSet(setId);
        return null;
      }
      final CardcastDeck deck = new CardcastDeck(StringEscapeUtils.escapeXml11(name), setId,
          StringEscapeUtils.escapeXml11(description));

      // load up the cards
      final JSONArray blacks = (JSONArray) cards.get("calls");
      if (null != blacks) {
        for (final Object black : blacks) {
          final JSONArray texts = (JSONArray) ((JSONObject) black).get("text");
          if (null != texts) {
            final String text = formatHelper.formatBlackCard(texts);
            final int pick = texts.size() - 1;
            final int draw = (pick >= 3 ? pick - 1 : 0);
            final CardcastBlackCard card = new CardcastBlackCard(cardIdProvider.get(), text, draw,
                pick, setId);
            deck.getBlackCards().add(card);
          }
        }
      }

      final JSONArray whites = (JSONArray) cards.get("responses");
      if (null != whites) {
        for (final Object white : whites) {
          final JSONArray texts = (JSONArray) ((JSONObject) white).get("text");
          if (null != texts) {
            final String text = formatHelper.formatWhiteCard(texts);
            // don't add blank cards, they don't do anything
            if (!text.isEmpty()) {
              final CardcastWhiteCard card = new CardcastWhiteCard(cardIdProvider.get(), text,
                  setId);
              deck.getWhiteCards().add(card);
            }
          }
        }
      }

      cacheSet(setId, deck);
      return deck;
    } catch (final Exception e) {
      LOG.error(String.format("Unable to load deck %s from Cardcast", setId), e);
      e.printStackTrace();
      cacheMissingSet(setId);
      return null;
    }
  }

  private void cachePut(final String setId, final CardcastDeck deck, final long timeout) {
    LOG.info(String.format("Caching %s=%s for %d ms", setId, deck, timeout));
    cache.put(setId, new SoftReference<CardcastCacheEntry>(new CardcastCacheEntry(timeout, deck)));
  }

  private void cacheSet(final String setId, final CardcastDeck deck) {
    cachePut(setId, deck, VALID_SET_CACHE_LIFETIME);
  }

  private void cacheMissingSet(final String setId) {
    cachePut(setId, null, INVALID_SET_CACHE_LIFETIME);
  }

  private String getUrlContent(final String urlStr) throws IOException {
    final URL url = new URL(urlStr);
    final HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setDoInput(true);
    conn.setDoOutput(false);
    conn.setRequestMethod("GET");
    conn.setInstanceFollowRedirects(true);
    conn.setReadTimeout(GET_TIMEOUT);
    conn.setConnectTimeout(GET_TIMEOUT);

    final int code = conn.getResponseCode();
    if (HttpURLConnection.HTTP_OK != code) {
      LOG.error(String.format("Got HTTP response code %d from Cardcast for %s", code, urlStr));
      return null;
    }
    final String contentType = conn.getContentType();
    if (!"application/json".equals(contentType)) {
      LOG.error(String.format("Got content-type %s from Cardcast for %s", contentType, urlStr));
      return null;
    }

    final InputStream is = conn.getInputStream();
    final InputStreamReader isr = new InputStreamReader(is);
    final BufferedReader reader = new BufferedReader(isr);
    final StringBuilder builder = new StringBuilder(4096);
    String line;
    while ((line = reader.readLine()) != null) {
      builder.append(line);
      builder.append('\n');
    }
    reader.close();
    isr.close();
    is.close();

    return builder.toString();
  }

  public static void hackSslVerifier() {
    // FIXME: My JVM doesn't like the certificate. I should go add StartSSL's root certificate to
    // its trust store, and document steps. For now, I'm going to disable SSL certificate checking.

    // Create a trust manager that does not validate certificate chains
    final TrustManager[] trustAllCerts = new TrustManager[] {
        new X509TrustManager() {
          @Override
          public X509Certificate[] getAcceptedIssuers() {
            return null;
          }

          @Override
          public void checkClientTrusted(final X509Certificate[] certs, final String authType) {
          }

          @Override
          public void checkServerTrusted(final X509Certificate[] certs, final String authType) {
          }
        }
    };

    try {
      final SSLContext sc = SSLContext.getInstance("SSL");
      sc.init(null, trustAllCerts, new java.security.SecureRandom());
      HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
    } catch (final Exception e) {
      LOG.error("Unable to install trust-all security manager", e);
    }

    // Create host name verifier that only trusts cardcast
    final HostnameVerifier allHostsValid = new HostnameVerifier() {
      @Override
      public boolean verify(final String hostname, final SSLSession session) {
        return HOSTNAME.equals(hostname);
      }
    };

    HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
  }
}
