/*
 * Copyright (c) 2012-2018, Andy Janata
 * All rights reserved.
 * <p>
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * <p>
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 * and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 * conditions and the following disclaimer in the documentation and/or other materials provided
 * with the distribution.
 * <p>
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package net.socialgamer.cah.servlets;

import com.google.inject.Injector;
import net.socialgamer.cah.Constants.*;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.StartupUtils;
import net.socialgamer.cah.data.User;
import org.jetbrains.annotations.Nullable;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;


/**
 * Servlet implementation class CahServlet.
 * <p>
 * Superclass for all CAH servlets. Provides utility methods to return errors and data, and to log.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public abstract class CahServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  private static JSONObject createObject(Map<ReturnableData, Object> data) {
    JSONObject obj = new JSONObject();
    for (ReturnableData key : data.keySet()) obj.put(key.toString(), data.get(key));
    return obj;
  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  @Override
  protected void doPost(final HttpServletRequest request, final HttpServletResponse response)
          throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    final String serialString = request.getParameter(AjaxRequest.SERIAL.toString());
    int serial = -1;
    if (null != serialString && !"".equals(serialString)) {
      try {
        serial = Integer.parseInt(serialString);
      } catch (final NumberFormatException e) {
        // pass
      }
    }

    try {
      final HttpSession hSession = request.getSession(true);
      final User user = (User) hSession.getAttribute(SessionAttribute.USER);

      final String op = request.getParameter(AjaxRequest.OP.toString());
      // we don't make sure they have a User object if they are doing either of the requests that
      // create or check for the User object. That would be silly.
      final boolean skipSessionUserCheck = op != null
              && (op.equals(AjaxOperation.REGISTER.toString())
              || op.equals(AjaxOperation.FIRST_LOAD.toString()));
      if (!skipSessionUserCheck && hSession.getAttribute(SessionAttribute.USER) == null) {
        returnError(response.getWriter(), ErrorCode.NOT_REGISTERED, serial);
      } else if (user != null
              && !user.isValidFromHost(new RequestWrapper(request).getRemoteAddr())) {
        // user probably pinged out, or possibly kicked by admin
        // or their IP address magically changed (working around a ban?)
        hSession.invalidate();
        returnError(response.getWriter(), ErrorCode.SESSION_EXPIRED, serial);
      } else {
        try {
          handleRequest(request, response, hSession);
        } catch (final AssertionError ae) {
          log("Assertion failed", ae);
          log(user, ae.toString());
        }
      }
    } catch (final IllegalStateException ise) {
      // session invalidated, so pretend they don't have one.
      returnError(response.getWriter(), ErrorCode.NO_SESSION, serial);
    }
  }

  /**
   * Handles a request from a CAH client. A session is guaranteed to exist at this point.
   *
   * @param request  The request data.
   * @param response The response to the client.
   * @param hSession The client's session.
   */
  protected abstract void handleRequest(final HttpServletRequest request,
                                        final HttpServletResponse response, final HttpSession hSession) throws ServletException,
          IOException;

  /**
   * Return an error to the client.
   *
   * @param writer Response writer to send the error data to.
   * @param code   Error code to return to client.
   * @param serial Request serial number from client.
   */
  protected void returnError(final PrintWriter writer, final ErrorCode code, final int serial) {
    final JSONObject ret = new JSONObject();
    ret.put(AjaxResponse.ERROR.toString(), Boolean.TRUE);
    ret.put(AjaxResponse.ERROR_CODE.toString(), code.toString());
    ret.put(AjaxResponse.SERIAL.toString(), serial);
    writer.println(ret.toString());
  }

  /**
   * Return response data to the client.
   *
   * @param writer Writer for the response.
   * @param data   Key-value data to return as the response.
   */
  protected void returnData(final PrintWriter writer, final Map<ReturnableData, Object> data) {
    returnObject(writer, createObject(data));
  }

  /**
   * Return multiple response data to the client.
   *
   * @param writer    Writer for the response.
   * @param data_list List of key-value data to return as the response.
   */
  protected void returnArray(final PrintWriter writer, final List<Map<ReturnableData, Object>> data_list) {
    JSONArray array = new JSONArray();
    for (Map<ReturnableData, Object> data : data_list)
      array.put(createObject(data));
    returnObject(writer, array);
  }

  /**
   * Return any response data to the client.
   *
   * @param writer Writer for the response.
   * @param object Data to return.
   */
  private void returnObject(final PrintWriter writer, final Object object) {
    writer.println(object.toString());
  }

  /**
   * @return Guice injector for the servlet context.
   */
  protected Injector getInjector() {
    return (Injector) getServletContext().getAttribute(StartupUtils.INJECTOR);
  }

  /**
   * Log a message, with the user's name if {@code user} is not null.
   *
   * @param user    The user this log message is about, or {@code null} if unknown.
   * @param message The message to log.
   */
  protected void log(@Nullable final User user, final String message) {
    final String userStr;
    if (user != null) {
      userStr = user.getNickname();
    } else {
      userStr = "unknown user";
    }
    log("For " + userStr + ": " + message);
  }
}
