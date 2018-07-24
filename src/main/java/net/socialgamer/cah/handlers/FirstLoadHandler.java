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

package net.socialgamer.cah.handlers;

import com.google.inject.Inject;
import net.socialgamer.cah.CahModule.*;
import net.socialgamer.cah.Constants.*;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.User;
import net.socialgamer.cah.db.PyxCardSet;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.http.HttpSession;
import java.util.*;


/**
 * Handler called for first invocation after a client loads. This can be used to restore a game in
 * progress if the browser reloads.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class FirstLoadHandler extends Handler {

  public static final String OP = AjaxOperation.FIRST_LOAD.toString();
  private static final Logger LOG = Logger.getLogger(FirstLoadHandler.class);
  private final Set<String> banList;
  private final Session hibernateSession;
  private final boolean includeInactiveCardsets;
  private final boolean globalChatEnabled;
  private final boolean showSessionPermalink;
  private final String sessionPermalinkFormatString;
  private final boolean showUserPermalink;
  private final String userPermalinkFormatString;
  private final Date serverStarted;

  @Inject
  public FirstLoadHandler(final Session hibernateSession, @BanList final Set<String> banList,
                          @IncludeInactiveCardsets final boolean includeInactiveCardsets,
                          @GlobalChatEnabled final boolean globalChatEnabled,
                          @ServerStarted final Date serverStarted,
                          @ShowSessionPermalink final boolean showSessionPermalink,
                          @SessionPermalinkUrlFormat final String sessionPermalinkFormatString,
                          @ShowUserPermalink final boolean showUserPermalink,
                          @UserPermalinkUrlFormat final String userPermalinkFormatString) {
    this.banList = banList;
    this.hibernateSession = hibernateSession;
    this.includeInactiveCardsets = includeInactiveCardsets;
    this.globalChatEnabled = globalChatEnabled;
    this.serverStarted = serverStarted;
    this.showSessionPermalink = showSessionPermalink;
    this.sessionPermalinkFormatString = sessionPermalinkFormatString;
    this.showUserPermalink = showUserPermalink;
    this.userPermalinkFormatString = userPermalinkFormatString;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request,
                                            final HttpSession session) {
    final HashMap<ReturnableData, Object> ret = new HashMap<>();
    ret.put(AjaxResponse.GLOBAL_CHAT_ENABLED, globalChatEnabled);

    if (banList.contains(request.getRemoteAddr())) {
      LOG.info(String.format("Rejecting user from %s because they are banned.",
              request.getRemoteAddr()));
      return error(ErrorCode.BANNED);
    }

    final User user = (User) session.getAttribute(SessionAttribute.USER);
    if (user == null) {
      ret.put(AjaxResponse.IN_PROGRESS, Boolean.FALSE);
      ret.put(AjaxResponse.NEXT, AjaxOperation.REGISTER.toString());
    } else {
      // They already have a session in progress, we need to figure out what they were doing
      // and tell the client where to continue from.
      ret.put(AjaxResponse.IN_PROGRESS, Boolean.TRUE);
      ret.put(AjaxResponse.NICKNAME, user.getNickname());
      ret.put(AjaxResponse.PERSISTENT_ID, user.getPersistentId());
      ret.put(AjaxResponse.ID_CODE, user.getIdCode());
      ret.put(AjaxResponse.SIGIL, user.getSigil().toString());
      if (showSessionPermalink) {
        ret.put(AjaxResponse.SESSION_PERMALINK,
                String.format(sessionPermalinkFormatString, user.getSessionId()));
      }
      if (showUserPermalink) {
        ret.put(AjaxResponse.USER_PERMALINK,
                String.format(userPermalinkFormatString, user.getPersistentId()));
      }

      if (user.getGame() != null) {
        ret.put(AjaxResponse.NEXT, ReconnectNextAction.GAME.toString());
        ret.put(AjaxResponse.GAME_ID, user.getGame().getId());
        user.getGame().maybeAddPermalinkToData(ret);
      } else {
        ret.put(AjaxResponse.NEXT, ReconnectNextAction.NONE.toString());
      }
    }

    try {
      // get the list of card sets
      final Transaction transaction = hibernateSession.beginTransaction();
      @SuppressWarnings("unchecked") final List<PyxCardSet> cardSets = hibernateSession
              .createQuery(PyxCardSet.getCardsetQuery(includeInactiveCardsets))
              .setReadOnly(true)
              .setCacheable(true)
              .list();
      final List<Map<CardSetData, Object>> cardSetsData =
              new ArrayList<>(cardSets.size());
      for (final PyxCardSet cardSet : cardSets) {
        cardSetsData.add(cardSet.getClientMetadata(hibernateSession));
      }
      ret.put(AjaxResponse.CARD_SETS, cardSetsData);
      transaction.commit();
    } finally {
      hibernateSession.close();
    }
    ret.put(AjaxResponse.SERVER_STARTED, serverStarted.getTime());
    return ret;
  }

}
