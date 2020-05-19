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

import com.google.inject.Inject;
import net.socialgamer.cah.data.GameOptions;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.ref.SoftReference;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.regex.Pattern;


public class CustomCardsService {
  private static final Logger LOG = Logger.getLogger(CustomCardsService.class);

  private static final int GET_TIMEOUT = (int) TimeUnit.SECONDS.toMillis(3);

  private static final Map<Integer, SoftReference<CustomDeck>> cache = Collections
      .synchronizedMap(new HashMap<Integer, SoftReference<CustomDeck>>());

  private static final Pattern VALID_WATERMARK_PATTERN = Pattern.compile("[A-Z0-9]{5}");

  private static final AtomicInteger cardIdCounter = new AtomicInteger(-(GameOptions.MAX_BLANK_CARD_LIMIT + 1));
  private static final AtomicInteger deckIdCounter = new AtomicInteger(0);

  @Inject
  public CustomCardsService() {
  }

  public static void hackSslVerifier() {
    // TODO: Nothing to hack?
  }

  public CustomDeck loadSet(int customDeckId) {
    SoftReference<CustomDeck> soft = cache.get(customDeckId);
    if (soft == null) {
      return null;
    }

    return soft.get();
  }

  public CustomDeck loadSetFromUrl(String url) {
    try {
      String content = getUrlContent(url);
      return loadSetFromJson(content);
    } catch (IOException e) {
      LOG.error(String.format("Unable to load deck from %s", url), e);
      e.printStackTrace();
      return null;
    }
  }

  public CustomDeck loadSetFromJson(String jsonStr) {
    try {
      JSONObject obj = (JSONObject) JSONValue.parse(jsonStr);

      final String name = (String) obj.get("name");
      final String description = (String) obj.get("description");
      final String watermark = (String) obj.get("watermark");
      if (null == name || null == description || name.isEmpty() || watermark == null || !VALID_WATERMARK_PATTERN.matcher(watermark).matches()) {
        // We require a name. Blank description is acceptable, but cannot be null. Watermark is required and must respect the pattern.
        return null;
      }

      int deckId = deckIdCounter.decrementAndGet();
      final CustomDeck deck = new CustomDeck(deckId, StringEscapeUtils.escapeXml11(name), StringEscapeUtils.escapeXml11(description));

      // load up the cards
      final JSONArray blacks = (JSONArray) obj.get("calls");
      if (null != blacks) {
        for (final Object black : blacks) {
          final JSONArray texts = (JSONArray) ((JSONObject) black).get("text");
          if (null != texts) {
            final String text = CustomCardFormatHelper.formatBlackCard(texts);
            final int pick = texts.size() - 1;
            final int draw = (pick >= 3 ? pick - 1 : 0);
            final CustomBlackCard card = new CustomBlackCard(cardIdCounter.decrementAndGet(), text, draw, pick, watermark);
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
              final CustomWhiteCard card = new CustomWhiteCard(cardIdCounter.decrementAndGet(), text, watermark);
              deck.getWhiteCards().add(card);
            }
          }
        }
      }

      cache.put(deckId, new SoftReference<CustomDeck>(deck));
      return deck;
    } catch (Exception e) {
      LOG.error("Unable to load deck.", e);
      e.printStackTrace();
      return null;
    }
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
      LOG.error(String.format("Got HTTP response code %d for %s", code, urlStr));
      return null;
    }
    final String contentType = conn.getContentType();
    if (!"application/json".equals(contentType)) {
      LOG.error(String.format("Got content-type %s for %s", contentType, urlStr));
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
}
