package net.socialgamer.cah.db;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import net.socialgamer.cah.Constants.WhiteCardData;


@Entity
@Table(name = "white_cards")
public class WhiteCard {
  @Id
  @GeneratedValue
  int id;
  String text;

  public int getId() {
    return id;
  }

  public void setId(final int id) {
    this.id = id;
  }

  public String getText() {
    return text;
  }

  public void setText(final String text) {
    this.text = text;
  }

  @Override
  public String toString() {
    return text + " (id:" + id + ")";
  }

  public Map<WhiteCardData, Object> getClientData() {
    final Map<WhiteCardData, Object> cardData = new HashMap<WhiteCardData, Object>();
    cardData.put(WhiteCardData.ID, id);
    cardData.put(WhiteCardData.TEXT, text);
    return cardData;
  }

  public static Map<WhiteCardData, Object> getBlankCardClientData() {
    final Map<WhiteCardData, Object> cardData = new HashMap<WhiteCardData, Object>();
    cardData.put(WhiteCardData.ID, -1);
    cardData.put(WhiteCardData.TEXT, "");
    return cardData;
  }
}
