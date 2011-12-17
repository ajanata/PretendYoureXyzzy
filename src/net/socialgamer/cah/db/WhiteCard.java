package net.socialgamer.cah.db;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


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

  public void setId(int id) {
    this.id = id;
  }

  public String getText() {
    return text;
  }

  public void setText(String text) {
    this.text = text;
  }

  @Override
  public String toString() {
    return text + " (id:" + id + ")";
  }
}
