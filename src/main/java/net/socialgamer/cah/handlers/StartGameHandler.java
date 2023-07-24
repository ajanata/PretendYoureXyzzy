/**
 * Copyright (c) 2012-2017, Andy Janata
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

package net.socialgamer.cah.handlers;

import com.google.inject.Inject;
import net.socialgamer.cah.Constants.*;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.CardSet;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;
import org.hibernate.Session;
import org.hibernate.exception.JDBCConnectionException;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Handler to start a game.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class StartGameHandler extends GameWithPlayerHandler {

  public static final String OP = AjaxOperation.START_GAME.toString();

  private final Session hibernateSession;

  @Inject
  public StartGameHandler(final GameManager gameManager, final Session session) {
    super(gameManager);
    this.hibernateSession = session;
  }

  @Override
  public Map<ReturnableData, Object> handleWithUserInGame(final RequestWrapper request,
                                                          final HttpSession session, final User user, final Game game) {
    final Map<ReturnableData, Object> data = new HashMap<>();

    try {
      if (game.getHost() != user) {
        return error(ErrorCode.NOT_GAME_HOST);
      } else if (game.getState() != GameState.LOBBY) {
        return error(ErrorCode.ALREADY_STARTED);
      } else if (!game.hasEnoughCards(hibernateSession)) {
        final List<CardSet> cardSets = game.loadCardSets(hibernateSession);
        data.put(ErrorInformation.BLACK_CARDS_PRESENT, game.loadBlackDeck(cardSets).totalCount());
        data.put(ErrorInformation.BLACK_CARDS_REQUIRED, Game.MINIMUM_BLACK_CARDS);
        data.put(ErrorInformation.WHITE_CARDS_PRESENT, game.loadWhiteDeck(cardSets).totalCount());
        data.put(ErrorInformation.WHITE_CARDS_REQUIRED, game.getRequiredWhiteCardCount());
        return error(ErrorCode.NOT_ENOUGH_CARDS, data);
      } else if (!game.start()) {
        return error(ErrorCode.NOT_ENOUGH_PLAYERS);
      } else {
        return data;
      }
    } catch (final JDBCConnectionException jce) {
      return error(ErrorCode.SERVER_ERROR);
    } finally {
      hibernateSession.close();
    }
  }
}
