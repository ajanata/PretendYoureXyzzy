/**
 * Copyright (c) 2012-2018, Andy Janata
 * All rights reserved.
 * <p>
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * <p>
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 * and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 * conditions and the following disclaimer in the documentation and/or other materials provided
 * with the distribution.
 * <p>
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

import com.google.inject.Inject;
import com.google.inject.Provider;
import net.socialgamer.cah.CahModule.*;
import net.socialgamer.cah.Constants.GameOptionData;
import net.socialgamer.cah.JsonWrapper;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;


/**
 * Options for an individual game.
 *
 * @author Gavin Lambert (uecasm)
 */
public class GameOptions {
    public final Set<Integer> cardSetIds = new HashSet<Integer>();
    public final int maxPlayerLimit;
    public final int defaultPlayerLimit;
    public final int minPlayerLimit;
    public final int maxSpectatorLimit;
    public final int defaultSpectatorLimit;
    public final int minSpectatorLimit;
    public final int minScoreLimit;
    public final int maxScoreLimit;
    public final int defaultScoreLimit;
    public final int minBlankCardLimit;
    public final int defaultBlankCardLimit;
    public final int maxBlankCardLimit;
    // These are the default values new games get.
    public int blanksInDeck;
    public int playerLimit;
    public int spectatorLimit;
    public int scoreGoal;
    public String password = "";
    public String timerMultiplier = "1x";

    @Inject
    public GameOptions(@MaxPlayerLimit int maxPlayerLimit, @DefaultPlayerLimit int defaultPlayerLimit, @MinPlayerLimit int minPlayerLimit,
                       @MaxSpectatorLimit int maxSpectatorLimit, @DefaultSpectatorLimit int defaultSpectatorLimit, @MinSpectatorLimit int minSpectatorLimit,
                       @MinScoreLimit int minScoreLimit, @MaxScoreLimit int maxScoreLimit, @DefaultScoreLimit int defaultScoreLimit,
                       @MinBlankCardLimit int minBlankCardLimit, @DefaultBlankCardLimit int defaultBlankCardLimit, @MaxBlankCardLimit int maxBlankCardLimit) {
        this.maxPlayerLimit = maxPlayerLimit;
        this.defaultPlayerLimit = playerLimit = defaultPlayerLimit;
        this.minPlayerLimit = minPlayerLimit;
        this.maxSpectatorLimit = maxSpectatorLimit;
        this.defaultSpectatorLimit = spectatorLimit = defaultSpectatorLimit;
        this.minSpectatorLimit = minSpectatorLimit;
        this.minScoreLimit = minScoreLimit;
        this.maxScoreLimit = maxScoreLimit;
        this.defaultScoreLimit = scoreGoal = defaultScoreLimit;
        this.minBlankCardLimit = minBlankCardLimit;
        this.defaultBlankCardLimit = blanksInDeck = defaultBlankCardLimit;
        this.maxBlankCardLimit = maxBlankCardLimit;
    }

    public static GameOptions deserialize(Provider<GameOptions> provider, final String text) {
        final GameOptions options = provider.get();

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

        options.blanksInDeck = Math.max(options.minBlankCardLimit, Math.min(options.maxBlankCardLimit,
                json.getInteger(GameOptionData.BLANKS_LIMIT, options.blanksInDeck)));
        options.playerLimit = Math.max(options.minPlayerLimit, Math.min(options.maxPlayerLimit,
                json.getInteger(GameOptionData.PLAYER_LIMIT, options.playerLimit)));
        options.spectatorLimit = Math.max(options.minSpectatorLimit, Math.min(options.maxSpectatorLimit,
                json.getInteger(GameOptionData.SPECTATOR_LIMIT, options.spectatorLimit)));
        options.scoreGoal = Math.max(options.minScoreLimit, Math.min(options.maxScoreLimit,
                json.getInteger(GameOptionData.SCORE_LIMIT, options.scoreGoal)));
        options.timerMultiplier = json.getString(GameOptionData.TIMER_MULTIPLIER, options.timerMultiplier);
        options.password = json.getString(GameOptionData.PASSWORD, options.password);

        return options;
    }

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
        this.timerMultiplier = newOptions.timerMultiplier;
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
        info.put(GameOptionData.TIMER_MULTIPLIER, timerMultiplier);
        if (includePassword) {
            info.put(GameOptionData.PASSWORD, password);
        }

        return info;
    }

    /**
     * @return Selected card set IDs which are local to PYX, for querying the database.
     */
    public Set<Integer> getPyxCardSetIds() {
        final Set<Integer> pyxCardSetIds = new HashSet<Integer>();
        for (final Integer cardSetId : cardSetIds) {
            if (cardSetId > 0) {
                pyxCardSetIds.add(cardSetId);
            }
        }
        return pyxCardSetIds;
    }
}
