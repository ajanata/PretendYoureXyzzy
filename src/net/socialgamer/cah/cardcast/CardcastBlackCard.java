package net.socialgamer.cah.cardcast;

import net.socialgamer.cah.data.BlackCard;


public class CardcastBlackCard extends BlackCard {

  private final int id;
  private final String text;
  private final int draw;
  private final int pick;

  public CardcastBlackCard(final int id, final String text, final int draw, final int pick) {
    this.id = id;
    this.text = text;
    this.draw = draw;
    this.pick = pick;
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
  public int getDraw() {
    return draw;
  }

  @Override
  public int getPick() {
    return pick;
  }
}
