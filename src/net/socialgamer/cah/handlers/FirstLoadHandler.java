package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.data.User;


/**
 * Handler called for first invocation after a client loads. This can be used to restore a game in
 * progress if the browser reloads.
 * 
 * @author ajanata
 * 
 */
public class FirstLoadHandler extends Handler {

  public static final String OP = AjaxOperation.FIRST_LOAD.toString();

  @Override
  public Map<String, Object> handle(final Map<String, String[]> parameters,
      final HttpSession session) {
    final HashMap<String, Object> ret = new HashMap<String, Object>();

    final User user = (User) session.getAttribute("user");
    if (user == null) {
      ret.put("in_progress", Boolean.FALSE);
      ret.put("next", "register");
    } else {
      // They already have a session in progress, we need to figure out what they were doing
      // and tell the client where to continue from.
      // Right now we just tell them what their name is.
      ret.put("in_progress", Boolean.TRUE);
      ret.put("next", ""); // TODO
      ret.put("nickname", user.getNickname());
    }

    return ret;
  }

}
