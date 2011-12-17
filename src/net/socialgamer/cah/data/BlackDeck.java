package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.List;

import net.socialgamer.cah.HibernateUtil;
import net.socialgamer.cah.db.BlackCard;

import org.hibernate.Session;


public class BlackDeck {
  private List<BlackCard> deck;
  private List<BlackCard> dealt;

  @SuppressWarnings("unchecked")
  public BlackDeck() {
    Session session = HibernateUtil.instance.sessionFactory.openSession();
    deck = (List<BlackCard>) session.createQuery("from BlackCard order by random()").list();
    dealt = new ArrayList<BlackCard>();
  }

  public BlackCard getNextCard() {
    // Without knowing what the implementation of List that Hibernate returns
    // is, I'm going to pull from the end instead of the beginning.
    BlackCard card = deck.get(deck.size() - 1);
    deck.remove(deck.size() - 1);
    dealt.add(card);
    return card;
  }
}
