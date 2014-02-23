/**
 * Copyright (c) 2012, Andy Janata
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

package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import net.socialgamer.cah.db.CardSet;
import net.socialgamer.cah.db.WhiteCard;


/**
 * Deck of White Cards.
 * 
 * This class is thread-safe.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class WhiteDeck {
  private final List<WhiteCard> deck;
  private final List<WhiteCard> discard;
  private int lastBlankCardId = -1;

  /**
   * Create a new white card deck, loading the cards from the database and shuffling them.
   */
  public WhiteDeck(final Collection<CardSet> cardSets, final int numBlanks) {
    final Set<WhiteCard> allCards = new HashSet<WhiteCard>();
    for (final CardSet cardSet : cardSets) {
      allCards.addAll(cardSet.getWhiteCards());
    }
    deck = new ArrayList<WhiteCard>(allCards);
    for (int i = 0; i < numBlanks; i++) {
      deck.add(createBlankCard());
    }
    Collections.shuffle(deck);
    discard = new ArrayList<WhiteCard>(deck.size());
  }

  /**
   * Get the next card from the top of deck.
   * 
   * @return The next card.
   * @throws OutOfCardsException
   *           There are no more cards in the deck.
   */
  public synchronized WhiteCard getNextCard() throws OutOfCardsException {
    if (deck.size() == 0) {
      throw new OutOfCardsException();
    }
    // we have an ArrayList here, so this is faster
    final WhiteCard card = deck.remove(deck.size() - 1);
    return card;
  }

  /**
   * Add a card to the discard pile.
   * 
   * @param card
   *          Card to add to discard pile.
   */
  public synchronized void discard(final WhiteCard card) {
    if (card != null) {
      if (isBlankCard(card)) {
        card.setText("____"); // clear any player text
      }
      discard.add(card);
    }
  }

  /**
   * Shuffles the discard pile and puts the cards under the cards remaining in the deck.
   */
  public synchronized void reshuffle() {
    Collections.shuffle(discard);
    deck.addAll(0, discard);
    discard.clear();
  }

  /**
   * Creates a new blank card.
   * 
   * @return A newly created blank card.
   */
  private WhiteCard createBlankCard() {
    final WhiteCard blank = new WhiteCard();
    blank.setId(--lastBlankCardId);
    blank.setText("____");
    blank.setWatermark("____");
    return blank;
  }

  /**
   * Checks if a particular card is a blank card.
   * 
   * @param card
   *          Card to check.
   * @return True if the card is a blank card.
   */
  public static boolean isBlankCard(final WhiteCard card) {
    return card.getId() < -1;
  }
}
