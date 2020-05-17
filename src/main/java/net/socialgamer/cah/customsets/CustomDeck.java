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

package net.socialgamer.cah.customsets;

import java.util.HashSet;
import java.util.Set;

import net.socialgamer.cah.data.CardSet;


public class CustomDeck extends CardSet {
  private final int id;
  private final String name;
  private final String description;
  private final Set<CustomBlackCard> blackCards = new HashSet<CustomBlackCard>();
  private final Set<CustomWhiteCard> whiteCards = new HashSet<CustomWhiteCard>();

  public CustomDeck(final int id, final String name, final String description) {
    this.id = id;
    this.name = name;
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
}
