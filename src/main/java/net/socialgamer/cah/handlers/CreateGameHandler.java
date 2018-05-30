/**
 * Copyright (c) 2012-2018, Andy Janata
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

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.google.inject.Inject;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;


/**
 * Handler to create a new game.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class CreateGameHandler extends Handler {

  public static final String OP = AjaxOperation.CREATE_GAME.toString();

  private final GameManager gameManager;

  @Inject
  public CreateGameHandler(final GameManager gameManager) {
    this.gameManager = gameManager;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session) {
    final Map<ReturnableData, Object> ret = new HashMap<ReturnableData, Object>();

    final User user = (User) session.getAttribute(SessionAttribute.USER);
    assert (user != null);

    Game game;
    try {
      game = gameManager.createGameWithPlayer(user);
    } catch (final IllegalStateException ise) {
      return error(ErrorCode.CANNOT_JOIN_ANOTHER_GAME);
    }
    if (game == null) {
      return error(ErrorCode.TOO_MANY_GAMES);
    } else {
      ret.put(AjaxResponse.GAME_ID, game.getId());
      game.maybeAddPermalinkToData(ret);
      return ret;
    }
  }
}
