package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.CahModule.BanList;
import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxRequest;
import net.socialgamer.cah.Constants.DisconnectReason;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.LongPollEvent;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.QueuedMessage;
import net.socialgamer.cah.data.QueuedMessage.MessageType;
import net.socialgamer.cah.data.User;

import org.apache.log4j.Logger;

import com.google.inject.Inject;


public class BanHandler extends Handler {
  protected final Logger logger = Logger.getLogger(BanHandler.class);

  public static final String OP = AjaxOperation.BAN.toString();

  private final ConnectedUsers connectedUsers;
  private final Set<String> banList;

  @Inject
  public BanHandler(final ConnectedUsers connectedUsers, @BanList final Set<String> banList) {
    this.connectedUsers = connectedUsers;
    this.banList = banList;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request, final HttpSession session) {
    final User user = (User) session.getAttribute(SessionAttribute.USER);
    assert (user != null);

    if (!user.isAdmin()) {
      return error(ErrorCode.NOT_ADMIN);
    }

    if (null == request.getParameter(AjaxRequest.NICKNAME)
        || request.getParameter(AjaxRequest.NICKNAME).isEmpty()) {
      return error(ErrorCode.NO_NICK_SPECIFIED);
    }

    final String banIp;
    final User kickUser = connectedUsers.getUser(request.getParameter(AjaxRequest.NICKNAME));
    if (null != kickUser) {
      banIp = kickUser.getHostName();

      final Map<ReturnableData, Object> kickData = new HashMap<ReturnableData, Object>();
      kickData.put(LongPollResponse.EVENT, LongPollEvent.BANNED.toString());
      final QueuedMessage qm = new QueuedMessage(MessageType.KICKED, kickData);
      kickUser.enqueueMessage(qm);

      connectedUsers.removeUser(kickUser, DisconnectReason.BANNED);
      logger.info(String.format("Banning %s (%s) by request of %s", kickUser.getNickname(), banIp,
          user.getNickname()));
    } else {
      banIp = request.getParameter(AjaxRequest.NICKNAME);
      logger.info(String.format("Banning %s by request of %s", banIp, user.getNickname()));
    }
    banList.add(banIp);

    return new HashMap<ReturnableData, Object>();
  }
}
