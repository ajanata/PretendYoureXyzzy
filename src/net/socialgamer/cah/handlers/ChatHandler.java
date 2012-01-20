package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxRequest;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.LongPollEvent;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.QueuedMessage.MessageType;
import net.socialgamer.cah.data.User;

import org.apache.commons.lang3.StringEscapeUtils;

import com.google.inject.Inject;


public class ChatHandler extends Handler {

  public static final String OP = AjaxOperation.CHAT.toString();

  private final ConnectedUsers users;

  @Inject
  public ChatHandler(final ConnectedUsers users) {
    this.users = users;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();

    final User user = (User) session.getAttribute(SessionAttribute.USER);
    assert (user != null);

    if (request.getParameter(AjaxRequest.MESSAGE) == null) {
      return error(ErrorCode.NO_MSG_SPECIFIED);
    } else {
      final String message = request.getParameter(AjaxRequest.MESSAGE).trim();
      if (message.length() > 200) {
        return error(ErrorCode.MESSAGE_TOO_LONG);
      } else {
        final HashMap<ReturnableData, Object> broadcastData = new HashMap<ReturnableData, Object>();
        broadcastData.put(LongPollResponse.EVENT, LongPollEvent.CHAT.toString());
        broadcastData.put(LongPollResponse.FROM, user.getNickname());
        broadcastData.put(LongPollResponse.MESSAGE, StringEscapeUtils.escapeXml(message));
        // TODO once there are multiple chat channels, put the destination here
        // TODO once there are games and they have their own chat, make it only send to participants
        users.broadcastToAll(MessageType.CHAT, broadcastData);
      }
    }

    return data;
  }
}
