package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;

import net.socialgamer.cah.HibernateUtil;
import net.socialgamer.cah.db.WhiteCard;


public class WhiteDeck {

  private List<WhiteCard> deck;
  private List<WhiteCard> dealt;

  @SuppressWarnings("unchecked")
  public WhiteDeck() {
    Session session = HibernateUtil.instance.sessionFactory.openSession();
    deck = (List<WhiteCard>) session.createQuery("from WhiteCard order by random()").list();
    dealt = new ArrayList<WhiteCard>();
  }

  public WhiteCard getNextCard() {
    // Without knowing what the implementation of List that Hibernate returns
    // is, I'm going to pull from the end instead of the beginning.
    WhiteCard card = deck.get(deck.size() - 1);
    deck.remove(deck.size() - 1);
    dealt.add(card);
    return card;
  }
}
