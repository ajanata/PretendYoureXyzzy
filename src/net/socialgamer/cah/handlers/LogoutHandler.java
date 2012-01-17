package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.DisconnectReason;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.Server;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class LogoutHandler extends Handler {

  public final static String OP = AjaxOperation.LOG_OUT.toString();

  private final ConnectedUsers users;

  @Inject
  public LogoutHandler(final Server server) {
    this.users = server.getConnectedUsers();
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();

    final User user = (User) session.getAttribute(SessionAttribute.USER);
    assert (user != null);

    user.noLongerVaild();
    users.removeUser(user, DisconnectReason.MANUAL);
    session.invalidate();
    return data;
  }
}
