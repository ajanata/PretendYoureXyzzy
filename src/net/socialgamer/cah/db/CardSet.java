package net.socialgamer.cah.db;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import net.socialgamer.cah.Constants.CardSetData;


@Entity
@Table(name = "card_set")
public class CardSet {

  @Id
  @GeneratedValue
  private int id;

  private String name;
  private String description;
  private boolean active;
  private boolean base_deck;

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

  public boolean isBaseDeck() {
    return base_deck;
  }

  public void setBaseDeck(final boolean baseDeck) {
    this.base_deck = baseDeck;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(final String description) {
    this.description = description;
  }

  /**
   * @return Client representation of this card set.
   */
  public Map<CardSetData, Object> getClientData() {
    final Map<CardSetData, Object> cardSetData = new HashMap<CardSetData, Object>();
    cardSetData.put(CardSetData.ID, getId());
    cardSetData.put(CardSetData.CARD_SET_NAME, getName());
    cardSetData.put(CardSetData.CARD_SET_DESCRIPTION, getDescription());
    cardSetData.put(CardSetData.BASE_DECK, isBaseDeck());
    cardSetData.put(CardSetData.BLACK_CARDS_IN_DECK, getBlackCards().size());
    cardSetData.put(CardSetData.WHITE_CARDS_IN_DECK, getWhiteCards().size());
    return cardSetData;
  }
}
