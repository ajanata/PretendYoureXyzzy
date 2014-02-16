package net.socialgamer.cah.db;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import net.socialgamer.cah.Constants.CardSetData;

import org.hibernate.Session;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;


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
  private int weight;

  @ManyToMany
  @JoinTable(
      name = "card_set_black_card",
      joinColumns = { @JoinColumn(name = "card_set_id") },
      inverseJoinColumns = { @JoinColumn(name = "black_card_id") })
  @LazyCollection(LazyCollectionOption.TRUE)
  private final Set<BlackCard> blackCards;

  @ManyToMany
  @JoinTable(
      name = "card_set_white_card",
      joinColumns = { @JoinColumn(name = "card_set_id") },
      inverseJoinColumns = { @JoinColumn(name = "white_card_id") })
  @LazyCollection(LazyCollectionOption.TRUE)
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

  public int getWeight() {
    return weight;
  }

  public void setWeight(final int weight) {
    this.weight = weight;
  }

  /**
   * Get the JSON representation of this card set's metadata. This method will cause lazy-loading of
   * the card collections.
   * @return Client representation of this card set.
   */
  public Map<CardSetData, Object> getClientMetadata() {
    final Map<CardSetData, Object> cardSetData = getCommonClientMetadata();
    cardSetData.put(CardSetData.BLACK_CARDS_IN_DECK, getBlackCards().size());
    cardSetData.put(CardSetData.WHITE_CARDS_IN_DECK, getWhiteCards().size());
    return cardSetData;
  }

  /**
   * Get the JSON representation of this card set's metadata. This method will not cause
   * lazy-loading of the card collections.
   * @return Client representation of this card set.
   */
  public Map<CardSetData, Object> getClientMetadata(final Session hibernateSession) {
    final Map<CardSetData, Object> cardSetData = getCommonClientMetadata();
    final Number blackCount = (Number) hibernateSession
        .createQuery("select count(*) from CardSet cs join cs.blackCards where cs.id = :id")
        .setParameter("id", id).uniqueResult();
    cardSetData.put(CardSetData.BLACK_CARDS_IN_DECK, blackCount);
    final Number whiteCount = (Number) hibernateSession
        .createQuery("select count(*) from CardSet cs join cs.whiteCards where cs.id = :id")
        .setParameter("id", id).uniqueResult();
    cardSetData.put(CardSetData.WHITE_CARDS_IN_DECK, whiteCount);
    return cardSetData;
  }

  private Map<CardSetData, Object> getCommonClientMetadata() {
    final Map<CardSetData, Object> cardSetData = new HashMap<CardSetData, Object>();
    cardSetData.put(CardSetData.ID, getId());
    cardSetData.put(CardSetData.CARD_SET_NAME, getName());
    cardSetData.put(CardSetData.CARD_SET_DESCRIPTION, getDescription());
    cardSetData.put(CardSetData.WEIGHT, getWeight());
    cardSetData.put(CardSetData.BASE_DECK, isBaseDeck());
    return cardSetData;
  }

  @Override
  public String toString() {
    return String.format(
        "CardSet[name=%s, base=%b, id=%d, active=%b, weight=%d, black=%d, white=%d]", name,
        base_deck, id, active, weight, blackCards.size(), whiteCards.size());
  }

  public static String getCardsetQuery(final Properties properties) {
    if (Boolean.valueOf(properties.getProperty("pyx.server.include_inactive_cardsets"))) {
      return "from CardSet order by weight, id";
    } else {
      return "from CardSet where active = true order by weight, id";
    }
  }
}
