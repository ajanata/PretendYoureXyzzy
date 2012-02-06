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

package net.socialgamer.cah.handlers;

import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxRequest;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;


/**
 * Handler superclass for handlers that require a game. This finds the game and makes sure it's
 * valid and specified.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public abstract class GameHandler extends Handler {

  protected GameManager gameManager;

  public GameHandler(final GameManager gameManager) {
    this.gameManager = gameManager;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request, final HttpSession session) {
    final User user = (User) session.getAttribute(SessionAttribute.USER);
    assert (user != null);

    final int gameId;

    if (request.getParameter(AjaxRequest.GAME_ID) == null) {
      return error(ErrorCode.NO_GAME_SPECIFIED);
    }
    try {
      gameId = Integer.parseInt(request.getParameter(AjaxRequest.GAME_ID));
    } catch (final NumberFormatException nfe) {
      return error(ErrorCode.INVALID_GAME);
    }

    final Game game = gameManager.getGame(gameId);
    if (game == null) {
      return error(ErrorCode.INVALID_GAME);
    }

    assert game.getId() == gameId : "Got a game with id not what we asked for.";

    return handle(request, session, user, game);
  }

  /**
   * Handle a client request. The {@code Game} is guaranteed to be valid.
   * 
   * @param request
   *          The request data.
   * @param session
   *          The client's session.
   * @param user
   *          The client's {@code User}.
   * @param game
   *          The {@code Game} for this request.
   * @return Response data.
   */
  public abstract Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session, final User user, final Game game);
}
