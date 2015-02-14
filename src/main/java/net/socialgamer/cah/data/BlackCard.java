package net.socialgamer.cah.data;

import java.util.HashMap;
import java.util.Map;

import net.socialgamer.cah.Constants.BlackCardData;


public abstract class BlackCard {

  public abstract int getId();

  public abstract String getText();

  public abstract String getWatermark();

  public abstract int getDraw();

  public abstract int getPick();

  @Override
  public final boolean equals(final Object other) {
    if (!(other instanceof BlackCard)) {
      return false;
    }
    return ((BlackCard) other).getId() == getId();
  }

  @Override
  public final int hashCode() {
    return getId();
  }

  /**
   * @return Client representation of this card.
   */
  public final Map<BlackCardData, Object> getClientData() {
    final Map<BlackCardData, Object> cardData = new HashMap<BlackCardData, Object>();
    cardData.put(BlackCardData.ID, getId());
    cardData.put(BlackCardData.TEXT, getText());
    cardData.put(BlackCardData.DRAW, getDraw());
    cardData.put(BlackCardData.PICK, getPick());
    cardData.put(BlackCardData.WATERMARK, getWatermark());
    return cardData;
  }

  @Override
  public String toString() {
    return String.format("%s %s (id:%d, draw:%d, pick:%d, watermark:%s)", getClass().getName(),
        getText(), getId(), getDraw(), getPick(), getWatermark());
  }
}
