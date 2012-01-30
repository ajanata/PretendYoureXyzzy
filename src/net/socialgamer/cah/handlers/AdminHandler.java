package net.socialgamer.cah.handlers;

import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;


public abstract class AdminHandler extends Handler {

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request, final HttpSession session) {
    final String remoteAddr = request.getRemoteAddr();
    if (!(remoteAddr.equals("0:0:0:0:0:0:0:1") || remoteAddr.equals("127.0.0.1"))) {
      return error(ErrorCode.ACCESS_DENIED);
    }

    return handle(request);
  }

  public abstract Map<ReturnableData, Object> handle(RequestWrapper request);
}
