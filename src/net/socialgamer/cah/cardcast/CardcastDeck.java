package net.socialgamer.cah.cardcast;

import java.util.HashSet;
import java.util.Set;

import net.socialgamer.cah.data.CardSet;


public class CardcastDeck extends CardSet {
  private final String name;
  private final String code;
  private final String description;
  private final Set<CardcastBlackCard> blackCards = new HashSet<CardcastBlackCard>();
  private final Set<CardcastWhiteCard> whiteCards = new HashSet<CardcastWhiteCard>();

  public CardcastDeck(final String name, final String code, final String description) {
    this.name = name;
    this.code = code;
    this.description = description;
  }

  @Override
  public int getId() {
    return -Integer.parseInt(code, 36);
  }

  @Override
  public String getName() {
    return name;
  }

  @Override
  public String getDescription() {
    return description;
  }

  @Override
  public boolean isActive() {
    return true;
  }

  @Override
  public boolean isBaseDeck() {
    return false;
  }

  @Override
  public int getWeight() {
    return Integer.MAX_VALUE;
  }

  @Override
  public Set<CardcastBlackCard> getBlackCards() {
    return blackCards;
  }

  @Override
  public Set<CardcastWhiteCard> getWhiteCards() {
    return whiteCards;
  }
}
