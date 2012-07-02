package net.socialgamer.cah.db;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;


@Entity
@Table(name = "card_set")
public class CardSet {

  @Id
  @GeneratedValue
  private int id;

  private String name;

  private boolean active;

  @ManyToMany
  @JoinTable(
      name = "card_set_black_card",
      joinColumns = { @JoinColumn(name = "card_set_id") },
      inverseJoinColumns = { @JoinColumn(name = "black_card_id") })
  private final Set<BlackCard> blackCards;

  @ManyToMany
  @JoinTable(
      name = "card_set_white_card",
      joinColumns = { @JoinColumn(name = "card_set_id") },
      inverseJoinColumns = { @JoinColumn(name = "white_card_id") })
  private final Set<WhiteCard> whiteCards;

  public CardSet() {
    blackCards = new HashSet<BlackCard>();
    whiteCards = new HashSet<WhiteCard>();
  }

  public String getName() {
    return name;
  }

  public void setName(final String name) {
    this.name = name;
  }

  public boolean isActive() {
    return active;
  }

  public void setActive(final boolean active) {
    this.active = active;
  }

  public int getId() {
    return id;
  }

  public Set<BlackCard> getBlackCards() {
    return blackCards;
  }

  public Set<WhiteCard> getWhiteCards() {
    return whiteCards;
  }
}
