package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import net.socialgamer.cah.HibernateUtil;
import net.socialgamer.cah.db.WhiteCard;

import org.hibernate.Session;


public class WhiteDeck {
  private final List<WhiteCard> deck;
  private final List<WhiteCard> dealt;
  private final List<WhiteCard> discard;

  @SuppressWarnings("unchecked")
  public WhiteDeck() {
    final Session session = HibernateUtil.instance.sessionFactory.openSession();
    // TODO option to restrict to only stock cards or allow customs
    deck = session.createQuery("from WhiteCard order by random()").list();
    dealt = new ArrayList<WhiteCard>();
    discard = new ArrayList<WhiteCard>();
  }

  public WhiteCard getNextCard() throws OutOfCardsException {
    if (deck.size() == 0) {
      throw new OutOfCardsException();
    }
    // Hibernate is returning an ArrayList, so this is a bit faster.
    final WhiteCard card = deck.get(deck.size() - 1);
    deck.remove(deck.size() - 1);
    dealt.add(card);
    return card;
  }

  public void discard(final WhiteCard card) {
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
