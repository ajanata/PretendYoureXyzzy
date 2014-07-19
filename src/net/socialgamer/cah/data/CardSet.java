package net.socialgamer.cah.data;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import net.socialgamer.cah.Constants.CardSetData;


public abstract class CardSet {

  public abstract int getId();

  public abstract String getName();

  public abstract String getDescription();

  public abstract boolean isActive();

  public abstract boolean isBaseDeck();

  public abstract int getWeight();

  public abstract Set<? extends BlackCard> getBlackCards();

  public abstract Set<? extends WhiteCard> getWhiteCards();

  /**
   * Get the JSON representation of this card set's metadata. This method will cause lazy-loading of
   * the card collections.
   * @return Client representation of this card set.
   */
  public final Map<CardSetData, Object> getClientMetadata() {
    final Map<CardSetData, Object> cardSetData = getCommonClientMetadata();
    cardSetData.put(CardSetData.BLACK_CARDS_IN_DECK, getBlackCards().size());
    cardSetData.put(CardSetData.WHITE_CARDS_IN_DECK, getWhiteCards().size());
    return cardSetData;
  }

  protected final Map<CardSetData, Object> getCommonClientMetadata() {
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
    return String.format("%s[name=%s, base=%b, id=%d, active=%b, weight=%d, black=%d, white=%d]",
        getClass().getName(), getName(), isBaseDeck(), getId(), isActive(), getWeight(),
        getBlackCards().size(), getWhiteCards().size());
  }
}
