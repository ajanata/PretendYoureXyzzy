package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.RequestWrapper;
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
  public Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session) {
    final HashMap<ReturnableData, Object> ret = new HashMap<ReturnableData, Object>();

    final User user = (User) session.getAttribute(SessionAttribute.USER);
    if (user == null) {
      ret.put(AjaxResponse.IN_PROGRESS, Boolean.FALSE);
      ret.put(AjaxResponse.NEXT, AjaxOperation.REGISTER.toString());
    } else {
      // They already have a session in progress, we need to figure out what they were doing
      // and tell the client where to continue from.
      // Right now we just tell them what their name is.
      ret.put(AjaxResponse.IN_PROGRESS, Boolean.TRUE);
      ret.put(AjaxResponse.NEXT, ""); // TODO
      ret.put(AjaxResponse.NICKNAME, user.getNickname());
    }

    return ret;
  }

}
