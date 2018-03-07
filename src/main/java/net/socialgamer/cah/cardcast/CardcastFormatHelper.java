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

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;


public class CardcastFormatHelper {

  public String formatBlackCard(final JSONArray textParts) {
    // TODO this is going to need some work to look pretty.
    final List<String> strs = new ArrayList<String>(textParts.size());
    for (final Object o : textParts) {
      strs.add((String) o);
    }
    final String text = StringUtils.join(strs, "____");
    return StringEscapeUtils.escapeXml11(text);
  }

  public String formatWhiteCard(final JSONArray textParts) {
    // The white cards should only ever have one element in text, but let's be safe.
    final List<String> strs = new ArrayList<String>(textParts.size());
    for (final Object o : textParts) {
      final String cardCastString = (String) o;
      if (cardCastString.isEmpty()) {
        // skip blank segments
        continue;
      }
      final StringBuilder pyxString = new StringBuilder();

      // Cardcast's recommended format is to not capitalize the first letter
      pyxString.append(cardCastString.substring(0, 1).toUpperCase());
      pyxString.append(cardCastString.substring(1));

      // Cardcast's recommended format is to not include a period
      if (Character.isLetterOrDigit(cardCastString.charAt(cardCastString.length() - 1))) {
        pyxString.append('.');
      }

      // Cardcast's white cards are now formatted consistently with pyx cards
      strs.add(pyxString.toString());
    }
    // escape before we do tag processing
    String text = StringEscapeUtils.escapeXml11(StringUtils.join(strs, ""));
    final String textLower = text.toLowerCase(Locale.ENGLISH);

    // allow [img] tags
    if (textLower.startsWith("[img]") && textLower.endsWith("[/img]")) {
      text = String.format(
          "<img src='%s' alt='A card with just a picture on it.' class='imagecard' />",
          text.substring("[img]".length(), text.length() - "[/img]".length()));
    }

    return text;
  }
}
