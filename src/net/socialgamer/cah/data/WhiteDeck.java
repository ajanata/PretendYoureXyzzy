package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.List;

import net.socialgamer.cah.HibernateUtil;
import net.socialgamer.cah.db.WhiteCard;

import org.hibernate.Session;


public class WhiteDeck {

  private final List<WhiteCard> deck;
  private final List<WhiteCard> dealt;

  @SuppressWarnings("unchecked")
  public WhiteDeck() {
    final Session session = HibernateUtil.instance.sessionFactory.openSession();
    // TODO option to restrict to only stock cards or allow customs
    deck = session.createQuery("from WhiteCard order by random()").list();
    dealt = new ArrayList<WhiteCard>();
  }

  public WhiteCard getNextCard() {
    // Without knowing what the implementation of List that Hibernate returns
    // is, I'm going to pull from the end instead of the beginning.
    final WhiteCard card = deck.get(deck.size() - 1);
    deck.remove(deck.size() - 1);
    dealt.add(card);
    return card;
  }
}
