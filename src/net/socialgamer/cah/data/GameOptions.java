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

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import net.socialgamer.cah.Constants.GameOptionData;
import net.socialgamer.cah.JsonWrapper;


/**
 * Options for an individual game.
 * 
 * @author Gavin Lambert (uecasm)
 */
public class GameOptions {
  // TODO move these out to pyx.properties
  public static final int MIN_SCORE_LIMIT = 4;
  public static final int DEFAULT_SCORE_LIMIT = 8;
  public static final int MAX_SCORE_LIMIT = 69;
  public static final int MIN_PLAYER_LIMIT = 3;
  public static final int DEFAULT_PLAYER_LIMIT = 10;
  public static final int MAX_PLAYER_LIMIT = 20;
  public static final int MIN_SPECTATOR_LIMIT = 0;
  public static final int DEFAULT_SPECTATOR_LIMIT = 10;
  public static final int MAX_SPECTATOR_LIMIT = 20;
  public static final int MIN_BLANK_CARD_LIMIT = 0;
  public static final int DEFAULT_BLANK_CARD_LIMIT = 0;
  public static final int MAX_BLANK_CARD_LIMIT = 30;

  // These are the default values new games get.
  public int blanksInDeck = DEFAULT_BLANK_CARD_LIMIT;
  public int playerLimit = DEFAULT_PLAYER_LIMIT;
  public int spectatorLimit = DEFAULT_SPECTATOR_LIMIT;
  public int scoreGoal = DEFAULT_SCORE_LIMIT;
  public final Set<Integer> cardSetIds = new HashSet<Integer>();
  public String password = "";
  public boolean useIdleTimer = true;

  /**
   * Update the options in-place (so that the Game doesn't need more locks).
   * 
   * @param newOptions
   *          The new options to use.
   */
  public void update(final GameOptions newOptions) {
    this.scoreGoal = newOptions.scoreGoal;
    this.playerLimit = newOptions.playerLimit;
    this.spectatorLimit = newOptions.spectatorLimit;
    synchronized (this.cardSetIds) {
      this.cardSetIds.clear();
      this.cardSetIds.addAll(newOptions.cardSetIds);
    }
    this.blanksInDeck = newOptions.blanksInDeck;
    this.password = newOptions.password;
    this.useIdleTimer = newOptions.useIdleTimer;
  }

  /**
   * Get the options in a form that can be sent to clients.
   * 
   * @param includePassword
   *          Include the actual password with the information. This should only be
   *          sent to people in the game.
   * @return This game's general information: ID, host, state, player list, etc.
   */
  public Map<GameOptionData, Object> serialize(final boolean includePassword) {
    final Map<GameOptionData, Object> info = new HashMap<GameOptionData, Object>();

    info.put(GameOptionData.CARD_SETS, cardSetIds);
    info.put(GameOptionData.BLANKS_LIMIT, blanksInDeck);
    info.put(GameOptionData.PLAYER_LIMIT, playerLimit);
    info.put(GameOptionData.SPECTATOR_LIMIT, spectatorLimit);
    info.put(GameOptionData.SCORE_LIMIT, scoreGoal);
    info.put(GameOptionData.USE_TIMER, useIdleTimer);
    if (includePassword) {
      info.put(GameOptionData.PASSWORD, password);
    }

    return info;
  }

  public static GameOptions deserialize(final String text) {
    final GameOptions options = new GameOptions();

    if (text == null || text.isEmpty()) {
      return options;
    }

    final JsonWrapper json = new JsonWrapper(text);

    final String[] cardSetsParsed = json.getString(GameOptionData.CARD_SETS, "").split(",");
    for (final String cardSetId : cardSetsParsed) {
      if (!cardSetId.isEmpty()) {
        options.cardSetIds.add(Integer.parseInt(cardSetId));
      }
    }

    options.blanksInDeck = Math.max(MIN_BLANK_CARD_LIMIT, Math.min(MAX_BLANK_CARD_LIMIT,
        json.getInteger(GameOptionData.BLANKS_LIMIT, options.blanksInDeck)));
    options.playerLimit = Math.max(MIN_PLAYER_LIMIT, Math.min(MAX_PLAYER_LIMIT,
        json.getInteger(GameOptionData.PLAYER_LIMIT, options.playerLimit)));
    options.spectatorLimit = Math.max(MIN_SPECTATOR_LIMIT, Math.min(MAX_SPECTATOR_LIMIT,
        json.getInteger(GameOptionData.SPECTATOR_LIMIT, options.spectatorLimit)));
    options.scoreGoal = Math.max(MIN_SCORE_LIMIT, Math.min(MAX_SCORE_LIMIT,
        json.getInteger(GameOptionData.SCORE_LIMIT, options.scoreGoal)));
    options.useIdleTimer = json.getBoolean(GameOptionData.USE_TIMER, options.useIdleTimer);
    options.password = json.getString(GameOptionData.PASSWORD, options.password);

    return options;
  }

}
