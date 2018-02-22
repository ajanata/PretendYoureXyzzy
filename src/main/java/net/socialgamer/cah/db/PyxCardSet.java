package net.socialgamer.cah.db;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.persistence.Cacheable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.Session;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import net.socialgamer.cah.Constants.CardSetData;
import net.socialgamer.cah.data.CardSet;


@Entity
@Table(name = "card_set")
@Cacheable
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
public class PyxCardSet extends CardSet {

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
  @Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
  private final Set<PyxBlackCard> blackCards;

  @ManyToMany
  @JoinTable(
      name = "card_set_white_card",
      joinColumns = { @JoinColumn(name = "card_set_id") },
      inverseJoinColumns = { @JoinColumn(name = "white_card_id") })
  @LazyCollection(LazyCollectionOption.TRUE)
  @Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
  private final Set<PyxWhiteCard> whiteCards;

  public PyxCardSet() {
    blackCards = new HashSet<PyxBlackCard>();
    whiteCards = new HashSet<PyxWhiteCard>();
  }

  @Override
  public String getName() {
    return name;
  }

  public void setName(final String name) {
    this.name = name;
  }

  @Override
  public boolean isActive() {
    return active;
  }

  public void setActive(final boolean active) {
    this.active = active;
  }

  @Override
  public int getId() {
    return id;
  }

  @Override
  public Set<PyxBlackCard> getBlackCards() {
    return blackCards;
  }

  @Override
  public Set<PyxWhiteCard> getWhiteCards() {
    return whiteCards;
  }

  @Override
  public boolean isBaseDeck() {
    return base_deck;
  }

  public void setBaseDeck(final boolean baseDeck) {
    this.base_deck = baseDeck;
  }

  @Override
  public String getDescription() {
    return description;
  }

  public void setDescription(final String description) {
    this.description = description;
  }

  @Override
  public int getWeight() {
    return weight;
  }

  public void setWeight(final int weight) {
    this.weight = weight;
  }

  /**
   * Get the JSON representation of this card set's metadata. This method will not cause
   * lazy-loading of the card collections.
   * @return Client representation of this card set.
   */
  public Map<CardSetData, Object> getClientMetadata(final Session hibernateSession) {
    final Map<CardSetData, Object> cardSetData = getCommonClientMetadata();
    final Number blackCount = (Number) hibernateSession
        .createQuery("select count(*) from PyxCardSet cs join cs.blackCards where cs.id = :id")
        .setParameter("id", id).setCacheable(true).uniqueResult();
    cardSetData.put(CardSetData.BLACK_CARDS_IN_DECK, blackCount);
    final Number whiteCount = (Number) hibernateSession
        .createQuery("select count(*) from PyxCardSet cs join cs.whiteCards where cs.id = :id")
        .setParameter("id", id).setCacheable(true).uniqueResult();
    cardSetData.put(CardSetData.WHITE_CARDS_IN_DECK, whiteCount);
    return cardSetData;
  }

  public static String getCardsetQuery(final boolean includeInactive) {
    if (includeInactive) {
      return "from PyxCardSet order by weight, name";
    } else {
      return "from PyxCardSet where active = true order by weight, name";
    }
  }
}
