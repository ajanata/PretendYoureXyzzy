package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.List;

import net.socialgamer.cah.HibernateUtil;
import net.socialgamer.cah.db.BlackCard;

import org.hibernate.Session;


public class BlackDeck {
  private final List<BlackCard> deck;
  private final List<BlackCard> dealt;

  @SuppressWarnings("unchecked")
  public BlackDeck() {
    final Session session = HibernateUtil.instance.sessionFactory.openSession();
    // TODO option to restrict to only stock cards or allow customs
    deck = session.createQuery("from BlackCard order by random()").list();
    dealt = new ArrayList<BlackCard>();
  }

  public BlackCard getNextCard() {
    // Without knowing what the implementation of List that Hibernate returns
    // is, I'm going to pull from the end instead of the beginning.
    final BlackCard card = deck.get(deck.size() - 1);
    deck.remove(deck.size() - 1);
    dealt.add(card);
    return card;
  }
}
