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

import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;


/**
 * Handler superclass for handlers that require a game and a user in that game. Ensures the game id
 * is valid, finds the game, and ensures that the client is actually in that game.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public abstract class GameWithPlayerHandler extends GameHandler {

  public GameWithPlayerHandler(final GameManager gameManager) {
    super(gameManager);
  }

  @Override
  public final Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session, final User user, final Game game) {
    // TODO when multiple games per user are supported, we need to change this.
    if (user.getGame() != game) {
      return error(ErrorCode.NOT_IN_THAT_GAME);
    } else {
      return handleWithUserInGame(request, session, user, game);
    }
  }

  /**
   * Handle a request, with a {@code Game} that is guaranteed to have the requesting {@code User} in
   * it.
   * 
   * @param request
   *          Request data.
   * @param session
   *          The client's session.
   * @param user
   *          The client's {@code User}.
   * @param game
   *          The {@code Game} for this request, which {@code user} is guaranteed to be in.
   * @return Response data.
   */
  public abstract Map<ReturnableData, Object> handleWithUserInGame(final RequestWrapper request,
      final HttpSession session, final User user, final Game game);
}
