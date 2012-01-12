package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.DisconnectReason;
import net.socialgamer.cah.Server;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class LogoutHandler extends Handler {

  public final static String OP = "logout";

  private final ConnectedUsers users;

  @Inject
  public LogoutHandler(final Server server) {
    this.users = server.getConnectedUsers();
  }

  @Override
  public Map<String, Object> handle(final Map<String, String[]> parameters,
      final HttpSession session) {
    final Map<String, Object> data = new HashMap<String, Object>();

    final User user = (User) session.getAttribute("user");
    assert (user != null);

    user.noLongerVaild();
    users.removeUser(user, DisconnectReason.MANUAL);
    session.invalidate();
    return data;
  }
}
