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
import net.socialgamer.cah.CahModule.GameChatEnabled;
import net.socialgamer.cah.Constants.*;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.QueuedMessage.MessageType;
import net.socialgamer.cah.data.User;
import net.socialgamer.cah.util.ChatFilter;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;


/**
 * Handler for chat messages.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class GameChatHandler extends GameWithPlayerHandler {
  public static final String OP = AjaxOperation.GAME_CHAT.toString();
  private final ChatFilter chatFilter;
  private final ConnectedUsers users;
  private final boolean gameChatEnabled;

  @Inject
  public GameChatHandler(final GameManager gameManager, final ChatFilter chatFilter,
                         final ConnectedUsers users, @GameChatEnabled final boolean gameChatEnabled) {
    super(gameManager);
    this.chatFilter = chatFilter;
    this.users = users;
    this.gameChatEnabled = gameChatEnabled;
  }

  @Override
  public Map<ReturnableData, Object> handleWithUserInGame(final RequestWrapper request,
                                                          final HttpSession session, final User user, final Game game) {
    final Map<ReturnableData, Object> data = new HashMap<>();
    final boolean emote = request.getParameter(AjaxRequest.EMOTE) != null
            && Boolean.valueOf(request.getParameter(AjaxRequest.EMOTE));

    LongPollEvent event = LongPollEvent.CHAT;
    if (request.getParameter(AjaxRequest.MESSAGE) == null) {
      return error(ErrorCode.NO_MSG_SPECIFIED);
    } else if (!gameChatEnabled && !user.isAdmin()) {
      // game chat can be turned off in the properties file
      return error(ErrorCode.NOT_ADMIN);
    } else {
      final String message = request.getParameter(AjaxRequest.MESSAGE).trim();

      final ChatFilter.Result filterResult = chatFilter.filterGame(user, message);
      ErrorCode error = filterResult.getErrorCode();
      if (error == null) {
        LongPollEvent filterEvent = filterResult.getEvent();
        if (filterEvent != null) event = filterEvent;
      } else {
        return error(error);
      }

      final HashMap<ReturnableData, Object> broadcastData = new HashMap<>();
      broadcastData.put(LongPollResponse.EVENT, event.toString());
      broadcastData.put(LongPollResponse.FROM, user.getNickname());
      broadcastData.put(LongPollResponse.MESSAGE, message);
      broadcastData.put(LongPollResponse.FROM_ADMIN, user.isAdmin());
      broadcastData.put(LongPollResponse.ID_CODE, user.getIdCode());
      broadcastData.put(LongPollResponse.SIGIL, user.getSigil().toString());
      broadcastData.put(LongPollResponse.GAME_ID, game.getId());
      broadcastData.put(LongPollResponse.EMOTE, emote);
      if (LongPollEvent.CHAT == event) {
        game.broadcastToPlayers(MessageType.CHAT, broadcastData);
      } else {
        users.broadcastToList(users.getAdmins(), MessageType.CHAT, broadcastData);
      }
    }

    return data;
  }
}
