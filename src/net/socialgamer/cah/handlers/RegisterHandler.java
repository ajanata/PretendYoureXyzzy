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

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.CahModule.BanList;
import net.socialgamer.cah.CahModule.MaxUsers;
import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxRequest;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.User;
import net.socialgamer.cah.db.Account;

import org.hibernate.Session;

import com.google.inject.Inject;


/**
 * Handler to register a name with the server and get connected.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class RegisterHandler extends Handler {

  public static final String OP = AjaxOperation.REGISTER.toString();

  private static final Pattern validName = Pattern.compile("[a-zA-Z_][a-zA-Z0-9_]{2,29}");

  private final ConnectedUsers users;
  private final Set<String> banList;
  private final Integer maxUsers;
  private final Session hibernateSession;

  @Inject
  public RegisterHandler(final ConnectedUsers users, @BanList final Set<String> banList,
      @MaxUsers final Integer maxUsers, final Session session) {
    this.users = users;
    this.banList = banList;
    this.maxUsers = maxUsers;
    this.hibernateSession = session;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();

    if (banList.contains(request.getRemoteAddr())) {
      return error(ErrorCode.BANNED);
    }

    if (request.getParameter(AjaxRequest.NICKNAME) == null) {
      return error(ErrorCode.NO_NICK_SPECIFIED);
    } else {
      final String nick = request.getParameter(AjaxRequest.NICKNAME).trim();
      if (!validName.matcher(nick).matches()) {
        return error(ErrorCode.INVALID_NICK);
      } else if ("xyzzy".equalsIgnoreCase(nick)) {
        return error(ErrorCode.RESERVED_NICK);
      } else {
        final String password = request.getParameter(AjaxRequest.PASSWORD);
        final Account account = Account.getAccount(hibernateSession, nick);
        if (null != account) {
          if (null == password || password.isEmpty()) {
            return error(ErrorCode.ACCOUNT_IS_REGISTERED);
          } else if (!account.getPassword().equals(password)) {
            // FIXME hash incoming password
            // wrong password
            return error(ErrorCode.WRONG_PASSWORD);
          }
        } else if (null != password && !password.isEmpty()) {
          // no account found
          return error(ErrorCode.ACCOUNT_NOT_REGISTERED);
        }

        final User user = new User(nick, request.getRemoteAddr(), account);
        final ErrorCode errorCode = users.checkAndAdd(user, maxUsers);
        if (null == errorCode) {
          // There is a findbugs warning on this line:
          // cah/src/net/socialgamer/cah/handlers/RegisterHandler.java:85 Store of non serializable
          // net.socialgamer.cah.data.User into HttpSession in
          // net.socialgamer.cah.handlers.RegisterHandler.handle(RequestWrapper, HttpSession)
          // I am choosing to ignore this for the time being as it works under light load, and I am
          // intending on moving away from HttpSession for storing user data in the not too distant
          // future, to fix issues with loading the game twice in the same browser.
          session.setAttribute(SessionAttribute.USER, user);

          data.put(AjaxResponse.NICKNAME, nick);
        } else {
          return error(errorCode);
        }
      }
    }
    return data;
  }
}
