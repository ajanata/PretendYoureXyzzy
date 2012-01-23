package net.socialgamer.cah.data;

import java.util.LinkedList;
import java.util.List;

import net.socialgamer.cah.db.WhiteCard;


public class Player {
  private final User user;

  private final List<WhiteCard> hand = new LinkedList<WhiteCard>();
  private int score = 0;

  public Player(final User user) {
    this.user = user;
  }

  public User getUser() {
    return user;
  }

  public int getScore() {
    return score;
  }

  public void increaseScore() {
    score++;
  }

  /**
   * @return The backing object for the player's hand (i.e., it can be modified).
   */
  public List<WhiteCard> getHand() {
    return hand;
  }

  @Override
  public String toString() {
    return user.toString();
  }
}
