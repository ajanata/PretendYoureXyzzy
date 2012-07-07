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

package net.socialgamer.cah.db;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import net.socialgamer.cah.Constants.BlackCardData;


/**
 * A Black Card. Cards are persisted in a database and loaded with Hibernate.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
@Entity
@Table(name = "black_cards")
public class BlackCard {

  @Id
  @GeneratedValue
  private int id;

  private String text;

  private int draw;

  private int pick;

  private String watermark;

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

  public String getWatermark() {
    return watermark == null ? "" : watermark;
  }

  public void setWatermark(final String watermark) {
    this.watermark = watermark;
  }

  @Override
  public String toString() {
    return text + " (id:" + id + ", draw:" + draw + ", pick:" + pick + ", watermark:"
        + getWatermark() + ")";
  }

  @Override
  public boolean equals(final Object other) {
    if (!(other instanceof BlackCard)) {
      return false;
    }
    return ((BlackCard) other).getId() == id;
  }

  @Override
  public int hashCode() {
    return id;
  }

  /**
   * @return Client representation of this card.
   */
  public Map<BlackCardData, Object> getClientData() {
    final Map<BlackCardData, Object> cardData = new HashMap<BlackCardData, Object>();
    cardData.put(BlackCardData.ID, id);
    cardData.put(BlackCardData.TEXT, text);
    cardData.put(BlackCardData.DRAW, draw);
    cardData.put(BlackCardData.PICK, pick);
    cardData.put(BlackCardData.WATERMARK, getWatermark());
    return cardData;
  }
}
