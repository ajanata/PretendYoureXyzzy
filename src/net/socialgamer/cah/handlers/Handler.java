package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;


/**
 * Implementations of this interface MUST also have a public static final String OP.
 * 
 * @author ajanata
 * 
 */
public abstract class Handler {
  public abstract Map<ReturnableData, Object> handle(RequestWrapper request,
      HttpSession session);

  protected Map<ReturnableData, Object> error(final ErrorCode errorCode) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
    data.put(AjaxResponse.ERROR, Boolean.TRUE);
    data.put(AjaxResponse.ERROR_CODE, errorCode.toString());
    //    data.put(AjaxResponse.ERROR_MESSAGE, message);
    return data;
  }
}
