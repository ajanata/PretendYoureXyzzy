package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import net.socialgamer.cah.HibernateUtil;
import net.socialgamer.cah.db.BlackCard;

import org.hibernate.Session;


public class BlackDeck {
  private final List<BlackCard> deck;
  private final List<BlackCard> dealt;
  private final List<BlackCard> discard;

  @SuppressWarnings("unchecked")
  public BlackDeck() {
    final Session session = HibernateUtil.instance.sessionFactory.openSession();
    // TODO option to restrict to only stock cards or allow customs
    deck = session.createQuery("from BlackCard order by random()").list();
    dealt = new ArrayList<BlackCard>();
    discard = new ArrayList<BlackCard>();
  }

  public BlackCard getNextCard() throws OutOfCardsException {
    if (deck.size() == 0) {
      throw new OutOfCardsException();
    }
    // Hibernate is returning an ArrayList, so this is a bit faster.
    final BlackCard card = deck.get(deck.size() - 1);
    deck.remove(deck.size() - 1);
    dealt.add(card);
    return card;
  }

  public void discard(final BlackCard card) {
    if (card != null) {
      discard.add(card);
    }
  }

  /**
   * Shuffles the discard pile and puts the cards under the cards remaining in the deck.
   */
  public void reshuffle() {
    Collections.shuffle(discard);
    deck.addAll(0, discard);
  }
}
