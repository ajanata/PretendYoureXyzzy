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
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxRequest;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class WhoisHandler extends Handler {

  public static final String OP = AjaxOperation.WHOIS.toString();

  private final ConnectedUsers users;

  @Inject
  public WhoisHandler(final ConnectedUsers users) {
    this.users = users;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request, final HttpSession session) {
    final User requestingUser = (User) session.getAttribute(SessionAttribute.USER);
    assert (requestingUser != null);
    final Map<ReturnableData, Object> ret = new HashMap<>();
    final String nick = request.getParameter(AjaxRequest.NICKNAME);
    if (null == nick || nick.trim().isEmpty()) {
      return error(ErrorCode.NO_NICK_SPECIFIED);
    }
    final User user = users.getUser(nick);
    if (null == user) {
      return error(ErrorCode.NO_SUCH_USER);
    }
    ret.put(AjaxResponse.NICKNAME, user.getNickname());
    ret.put(AjaxResponse.SIGIL, user.getSigil().toString());
    ret.put(AjaxResponse.ID_CODE, user.getIdCode());
    ret.put(AjaxResponse.CONNECTED_AT, user.getConnectedAt());
    ret.put(AjaxResponse.IDLE,
        TimeUnit.NANOSECONDS.toMillis(System.nanoTime() - user.getLastUserAction()));
    final Game game = user.getGame();
    if (null != game) {
      ret.put(AjaxResponse.GAME_ID, game.getId());
      // overkill but has multiple pieces of information we want
      ret.put(AjaxResponse.GAME_INFO, game.getInfo());
    }
    if (requestingUser.isAdmin()) {
      ret.put(AjaxResponse.IP_ADDRESS, user.getHostname());
      ret.put(AjaxResponse.CLIENT_NAME, user.getAgentName() + " on " + user.getAgentOs());
    }
    return ret;
  }
}
