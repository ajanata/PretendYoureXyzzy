package net.socialgamer.cah.db;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


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

  public void setId(int id) {
    this.id = id;
  }

  public String getText() {
    return text;
  }

  public void setText(String text) {
    this.text = text;
  }

  public int getDraw() {
    return draw;
  }

  public void setDraw(int draw) {
    this.draw = draw;
  }

  public int getPick() {
    return pick;
  }

  public void setPick(int pick) {
    this.pick = pick;
  }

  @Override
  public String toString() {
    return text + " (id:" + id + ", draw:" + draw + ", pick:" + pick + ")";
  }
}
