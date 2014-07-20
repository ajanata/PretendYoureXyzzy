package net.socialgamer.cah.cardcast;

import net.socialgamer.cah.data.WhiteCard;


public class CardcastWhiteCard extends WhiteCard {

  private final int id;
  private final String text;

  public CardcastWhiteCard(final int id, final String text) {
    this.id = id;
    this.text = text;
  }

  @Override
  public int getId() {
    return id;
  }

  @Override
  public String getText() {
    return text;
  }

  @Override
  public String getWatermark() {
    return "CC";
  }

  @Override
  public boolean isWriteIn() {
    return false;
  }
}
