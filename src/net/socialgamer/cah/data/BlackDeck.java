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
import java.util.Collections;
import java.util.List;

import net.socialgamer.cah.HibernateUtil;
import net.socialgamer.cah.db.BlackCard;

import org.hibernate.Session;
import org.hibernate.Transaction;


/**
 * Deck of Black Cards.
 * 
 * This class is thread-safe.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class BlackDeck {
  private final List<BlackCard> deck;
  private final List<BlackCard> dealt;
  private final List<BlackCard> discard;

  /**
   * Create a new black card deck, loading the cards from the database and shuffling them.
   */
  @SuppressWarnings("unchecked")
  public BlackDeck(final int cardSet) {
    final Session session = HibernateUtil.instance.sessionFactory.openSession();
    final Transaction transaction = session.beginTransaction();
    transaction.begin();
    // TODO option to restrict to only stock cards or allow customs
    String query = "from BlackCard order by random()";
    if (1 == cardSet) {
      query = "from BlackCard where in_v1 = true order by random()";
    } else if (2 == cardSet) {
      query = "from BlackCard where in_v2 = true order by random()";
    }
    deck = session.createQuery(query).setReadOnly(true).list();
    dealt = new ArrayList<BlackCard>();
    discard = new ArrayList<BlackCard>();
    transaction.commit();
  }

  /**
   * Get the next card from the top of deck.
   * 
   * @return The next card.
   * @throws OutOfCardsException
   *           There are no more cards in the deck.
   */
  public synchronized BlackCard getNextCard() throws OutOfCardsException {
    if (deck.size() == 0) {
      throw new OutOfCardsException();
    }
    // Hibernate is returning an ArrayList, so this is a bit faster.
    final BlackCard card = deck.remove(deck.size() - 1);
    dealt.add(card);
    return card;
  }

  /**
   * Add a card to the discard pile.
   * 
   * @param card
   *          Card to add to discard pile.
   */
  public synchronized void discard(final BlackCard card) {
    if (card != null) {
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
}
