package net.socialgamer.cah.data;

public class BlankWhiteCard extends WhiteCard {
  private static final String BLANK_TEXT = "____";
  private final int id;
  private String text;

  public BlankWhiteCard(final int id) {
    this.id = id;
    clear();
  }

  @Override
  public int getId() {
    return id;
  }

  @Override
  public String getText() {
    return text;
  }

  public void setText(final String text) {
    this.text = text;
  }

  public void clear() {
    setText(BLANK_TEXT);
  }

  @Override
  public String getWatermark() {
    return "____";
  }

  @Override
  public boolean isWriteIn() {
    return true;
  }
}
