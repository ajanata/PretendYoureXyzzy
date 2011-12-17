package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class RegisterHandler implements Handler {

  public static final String OP = "register";

  private final ConnectedUsers users;

  @Inject
  public RegisterHandler(final ConnectedUsers users) {
    this.users = users;
  }

  @Override
  public Map<String, Object> handle(final Map<String, String[]> parameters,
      final HttpSession session) {
    final HashMap<String, Object> ret = new HashMap<String, Object>();

    if (!parameters.containsKey("nickname") || parameters.get("nickname").length != 1) {
      ret.put("error", Boolean.TRUE);
      ret.put("error_message", "No nickname specified.");
    } else {
      final String nick = parameters.get("nickname")[0].trim();
      if (nick.length() < 3) {
        ret.put("error", Boolean.TRUE);
        ret.put("error_message", "Nickname " + nick
            + " is too short. Minimum length is 3 characters.");
      } else if (nick.length() > 30) {
        ret.put("error", Boolean.TRUE);
        ret.put("error_message", "Nickname " + nick
            + " is too long. Maximum length is 30 characters.");
      } else if (users.hasUser(nick)) {
        ret.put("error", Boolean.TRUE);
        ret.put("error_message", "Nickname " + nick + " already in use.");
      } else {
        // TODO this will get cluttered until we do pinging
        final User user = new User(nick);
        users.newUser(user);
        session.setAttribute("user", user);

        ret.put("nickname", nick);
      }
    }
    return ret;
  }
}
