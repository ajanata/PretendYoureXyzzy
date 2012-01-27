package net.socialgamer.cah.db;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import net.socialgamer.cah.Constants.BlackCardData;


@Entity
@Table(name = "black_cards")
public class BlackCard {
  @Id
  @GeneratedValue
  int id;
  String text;
  int draw;
  int pick;

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

  public int getDraw() {
    return draw;
  }

  public void setDraw(final int draw) {
    this.draw = draw;
  }

  public int getPick() {
    return pick;
  }

  public void setPick(final int pick) {
    this.pick = pick;
  }

  @Override
  public String toString() {
    return text + " (id:" + id + ", draw:" + draw + ", pick:" + pick + ")";
  }

  public Map<BlackCardData, Object> getClientData() {
    final Map<BlackCardData, Object> cardData = new HashMap<BlackCardData, Object>();
    cardData.put(BlackCardData.ID, id);
    cardData.put(BlackCardData.TEXT, text);
    cardData.put(BlackCardData.DRAW, draw);
    cardData.put(BlackCardData.PICK, pick);
    return cardData;
  }
}
