/**
 * Copyright (c) 2012, Andy Janata
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * 
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 *   and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 *   conditions and the following disclaimer in the documentation and/or other materials provided
 *   with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package net.socialgamer.cah.data;

import java.util.LinkedList;
import java.util.List;

import net.socialgamer.cah.db.WhiteCard;


/**
 * Data required for a player in a {@code Game}.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class Player {
  private final User user;

  private final List<WhiteCard> hand = new LinkedList<WhiteCard>();
  private int score = 0;
  private int skipCount = 0;

  /**
   * Create a new player object.
   * 
   * @param user
   *          The {@code User} associated with this player.
   */
  public Player(final User user) {
    this.user = user;
  }

  /**
   * @return The {@code User} associated with this player.
   */
  public User getUser() {
    return user;
  }

  /**
   * @return The player's score.
   */
  public int getScore() {
    return score;
  }

  /**
   * Increase the player's score by 1 point.
   */
  public void increaseScore() {
    score++;
  }

  /**
   * Increase the player's score by the specified amount.
   */
  public void increaseScore(final int offset) {
    score += offset;
  }

  /**
   * Reset the player's score to 0.
   */
  public void resetScore() {
    score = 0;
  }

  /**
   * Increases this player's skipped round count.
   */
  public void skipped() {
    skipCount++;
  }

  /**
   * Reset this player's skipped round count to 0, because they have been back for a round.
   */
  public void resetSkipCount() {
    skipCount = 0;
  }

  /**
   * @return This player's skipped round count.
   */
  public int getSkipCount() {
    return skipCount;
  }

  /**
   * @return The backing object for the player's hand (i.e., it can be modified).
   */
  public List<WhiteCard> getHand() {
    return hand;
  }

  @Override
  public String toString() {
    return String.format("%s (%dp, %ds)", user.toString(), score, skipCount);
  }
}
