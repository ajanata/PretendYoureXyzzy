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

import java.util.HashSet;
import java.util.Set;

import net.socialgamer.cah.data.CardSet;


public class CardcastDeck extends CardSet {
  private final String name;
  private final String code;
  private final String description;
  private final Set<CardcastBlackCard> blackCards = new HashSet<CardcastBlackCard>();
  private final Set<CardcastWhiteCard> whiteCards = new HashSet<CardcastWhiteCard>();

  public CardcastDeck(final String name, final String code, final String description) {
    this.name = name;
    this.code = code;
    this.description = description;
  }

  @Override
  public int getId() {
    return -Integer.parseInt(code, 36);
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
  public Set<CardcastBlackCard> getBlackCards() {
    return blackCards;
  }

  @Override
  public Set<CardcastWhiteCard> getWhiteCards() {
    return whiteCards;
  }
}
