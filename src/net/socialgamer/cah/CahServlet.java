package net.socialgamer.cah;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxRequest;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.data.User;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.google.inject.Injector;
import com.sun.istack.internal.Nullable;


/**
 * Servlet implementation class CahServlet
 */
// @WebServlet("/CahServlet")
public abstract class CahServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  private final boolean debugLog = false;

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  @Override
  protected void doPost(final HttpServletRequest request, final HttpServletResponse response)
      throws ServletException, IOException {
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    final HttpSession hSession = request.getSession(true);
    final User user = (User) hSession.getAttribute(SessionAttribute.USER);

    if (verboseDebug()) {
      // TODO if we have any sort of authentication later, we need to make sure to not log passwords!
      // I could use getParameterMap, but that returns an array, and getting pretty strings out of
      // array values is a lot of work.
      final Map<String, Object> params = new HashMap<String, Object>();
      final Enumeration<String> paramNames = request.getParameterNames();
      while (paramNames.hasMoreElements()) {
        final String name = paramNames.nextElement();
        params.put(name, request.getParameter(name));
      }
      log(user, "Request: " + JSONValue.toJSONString(params));
    }

    final String op = request.getParameter(AjaxRequest.OP.toString());
    final boolean skipSessionUserCheck = op != null
        && (op.equals(AjaxOperation.REGISTER.toString())
        || op.equals(AjaxOperation.FIRST_LOAD.toString()));
    if (hSession.isNew()) {
      // they should have gotten a session from the index page.
      // they probably don't have cookies on.
      returnError(user, response.getWriter(), ErrorCode.NO_SESSION);
    } else if (!skipSessionUserCheck && hSession.getAttribute(SessionAttribute.USER) == null) {
      returnError(user, response.getWriter(), ErrorCode.NOT_REGISTERED);
    } else if (user != null && !user.isValid()) {
      // user probably pinged out
      hSession.invalidate();
      returnError(user, response.getWriter(), ErrorCode.SESSION_EXPIRED);
    } else {
      try {
        handleRequest(request, response, hSession);
      } catch (final AssertionError ae) {
        log("Assertion failed", ae);
        getServletContext().log(ae.toString());
        ae.printStackTrace();
      }
    }
  }

  private boolean verboseDebug() {
    final Boolean verboseDebugObj = (Boolean) getServletContext().getAttribute(
        StartupUtils.VERBOSE_DEBUG);
    final boolean verboseDebug = verboseDebugObj != null ? verboseDebugObj.booleanValue() : false;
    return verboseDebug;
  }

  /**
   * Handles a request from a CAH client. A session is guaranteed to exist at this point.
   * 
   * @param request
   * @param response
   * @param hSession
   * @throws ServletException
   * @throws IOException
   */
  protected abstract void handleRequest(final HttpServletRequest request,
      final HttpServletResponse response, final HttpSession hSession) throws ServletException,
      IOException;

  /**
   * Return an error to the client. Prefer to use the PrintWriter,String,String,int version if you
   * know the request serial number.
   * 
   * @param writer
   * @param code
   *          Error code that the js code knows how to handle.
   */
  protected void returnError(@Nullable final User user, final PrintWriter writer,
      final ErrorCode code) {
    returnError(user, writer, code, -1);
  }

  /**
   * Return an error to the client.
   * 
   * @param writer
   * @param serial
   */
  @SuppressWarnings("unchecked")
  protected void returnError(@Nullable final User user, final PrintWriter writer,
      final ErrorCode code,
      final int serial) {
    final JSONObject ret = new JSONObject();
    ret.put(AjaxResponse.ERROR, Boolean.TRUE);
    ret.put(AjaxResponse.ERROR_CODE, code.toString());
    writer.println(ret.toJSONString());
  }

  /**
   * Return response data to the client.
   * 
   * @param writer
   *          Writer for the response.
   * @param data
   *          Key-value data to return as the response.
   */
  protected void returnData(@Nullable final User user, final PrintWriter writer,
      final Map<ReturnableData, Object> data) {
    returnObject(user, writer, data);
  }

  /**
   * Return multiple response data to the client.
   * 
   * @param writer
   *          Writer for the response.
   * @param data_list
   *          List of key-value data to return as the response.
   */
  protected void returnArray(@Nullable final User user, final PrintWriter writer,
      final List<Map<ReturnableData, Object>> data_list) {
    returnObject(user, writer, data_list);
  }

  private void returnObject(@Nullable final User user, final PrintWriter writer, final Object object) {
    final String ret = JSONValue.toJSONString(object);
    writer.println(ret);
    if (verboseDebug()) {
      log(user, "Response: " + ret);
    }
  }

  protected Injector getInjector() {
    return (Injector) getServletContext().getAttribute(StartupUtils.INJECTOR);
  }

  protected void log(@Nullable final User user, final String message) {
    String userStr = "unknown user";
    if (user != null) {
      userStr = user.getNickname();
    }
    log("For " + userStr + ": " + message);
  }
}
