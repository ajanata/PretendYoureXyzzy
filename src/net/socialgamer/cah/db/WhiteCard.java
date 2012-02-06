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

import net.socialgamer.cah.Constants.WhiteCardData;


/**
 * A white Card. Cards are persisted in a database and loaded with Hibernate.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
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

  /**
   * @return Client representation of this card.
   */
  public Map<WhiteCardData, Object> getClientData() {
    final Map<WhiteCardData, Object> cardData = new HashMap<WhiteCardData, Object>();
    cardData.put(WhiteCardData.ID, id);
    cardData.put(WhiteCardData.TEXT, text);
    return cardData;
  }

  /**
   * @return Client representation of a blank White Card.
   */
  public static Map<WhiteCardData, Object> getBlankCardClientData() {
    final Map<WhiteCardData, Object> cardData = new HashMap<WhiteCardData, Object>();
    cardData.put(WhiteCardData.ID, -1);
    cardData.put(WhiteCardData.TEXT, "");
    return cardData;
  }
}
