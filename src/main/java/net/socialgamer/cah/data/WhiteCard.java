package net.socialgamer.cah.data;

import net.socialgamer.cah.Constants.WhiteCardData;

import java.util.HashMap;
import java.util.Map;


public abstract class WhiteCard {

  /**
   * @return Client representation of a face-down White Card.
   */
  public static Map<WhiteCardData, Object> getFaceDownCardClientData() {
    final Map<WhiteCardData, Object> cardData = new HashMap<>();
    cardData.put(WhiteCardData.ID, -1);
    cardData.put(WhiteCardData.TEXT, "");
    cardData.put(WhiteCardData.WATERMARK, "");
    cardData.put(WhiteCardData.WRITE_IN, false);
    return cardData;
  }

  public abstract int getId();

  public abstract String getText();

  public abstract String getWatermark();

  public abstract boolean isWriteIn();

  @Override
  public final boolean equals(final Object other) {
    if (!(other instanceof WhiteCard)) {
      return false;
    }
    return ((WhiteCard) other).getId() == getId();
  }

  @Override
  public final int hashCode() {
    return getId();
  }

  /**
   * @return Client representation of this card.
   */
  public final Map<WhiteCardData, Object> getClientData() {
    final Map<WhiteCardData, Object> cardData = new HashMap<>();
    cardData.put(WhiteCardData.ID, getId());
    cardData.put(WhiteCardData.TEXT, getText());
    cardData.put(WhiteCardData.WATERMARK, getWatermark());
    cardData.put(WhiteCardData.WRITE_IN, isWriteIn());
    return cardData;
  }

  @Override
  public String toString() {
    return String.format("%s %s (id:%d, watermark:%s)", getClass().getName(), getText(), getId(),
            getWatermark());
  }

}
