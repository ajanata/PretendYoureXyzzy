package net.socialgamer.cah;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.handlers.Handler;
import net.socialgamer.cah.handlers.Handlers;


/**
 * Servlet implementation class AjaxServlet
 * 
 * This servlet is only used for client actions, not for long-polling.
 */
@WebServlet("/AjaxServlet")
public class AjaxServlet extends CahServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see CahServlet#doPost(HttpServletRequest request, HttpServletResponse response, HttpSession
   *      hSession)
   */
  @Override
  protected void handleRequest(final HttpServletRequest request,
      final HttpServletResponse response, final HttpSession hSession) throws ServletException,
      IOException {
    final PrintWriter out = response.getWriter();
    int serial = -1;
    if (request.getParameter("serial") != null) {
      try {
        serial = Integer.parseInt(request.getParameter("serial"));
      } catch (final NumberFormatException nfe) {
        returnError(out, ErrorCode.BAD_REQUEST);
        return;
      }
    }

    final String op = request.getParameter("op");
    //  !Handlers.LIST.containsKey(op)
    if (op == null || op.equals("")) {
      returnError(out, ErrorCode.OP_NOT_SPECIFIED, serial);
      return;
    }

    final Handler handler;
    try {
      handler = getInjector().getInstance(Handlers.LIST.get(op));
    } catch (final Exception e) {
      returnError(out, ErrorCode.BAD_OP, serial);
      return;
    }
    final Map<ReturnableData, Object> data = handler.handle(request.getParameterMap(), hSession);
    data.put(AjaxResponse.SERIAL, serial);
    returnData(out, data);
    return;
  }

}
