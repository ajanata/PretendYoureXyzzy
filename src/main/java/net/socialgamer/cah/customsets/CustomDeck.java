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

import net.socialgamer.cah.Constants;
import net.socialgamer.cah.data.CardSet;

import net.socialgamer.cah.data.CardSet;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;


public class CustomDeck extends CardSet {
  private final int id;
  private final String name;
  private final String watermark;
  private final String description;
  private final Set<CustomBlackCard> blackCards = new HashSet<>();
  private final Set<CustomWhiteCard> whiteCards = new HashSet<>();

  public CustomDeck(final int id, final String name, final String watermark, final String description) {
    this.id = id;
    this.name = name;
    this.watermark = watermark;
    this.description = description;

    if (id >= 0) throw new IllegalArgumentException("Custom deck ID must be negative.");
  }

  @Override
  public int getId() {
    return id;
  }

  @Override
  public String getName() {
    return name;
  }

  @Override
  public String getDescription() {
    return description;
  }

  @Override
  public boolean isActive() {
    return true;
  }

  @Override
  public boolean isBaseDeck() {
    return false;
  }

  @Override
  public int getWeight() {
    return Integer.MAX_VALUE;
  }

  @Override
  public Set<CustomBlackCard> getBlackCards() {
    return blackCards;
  }

  @Override
  public Set<CustomWhiteCard> getWhiteCards() {
    return whiteCards;
  }

  @Override
  protected Map<Constants.CardSetData, Object> getCommonClientMetadata() {
    Map<Constants.CardSetData, Object> data = super.getCommonClientMetadata();
    data.put(Constants.CardSetData.WATERMARK, watermark);
    return data;
  }
}
