package net.socialgamer.cah;

import java.io.IOException;
import java.io.PrintWriter;
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


/**
 * Servlet implementation class CahServlet
 */
// @WebServlet("/CahServlet")
public abstract class CahServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public CahServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  @Override
  protected void doPost(final HttpServletRequest request, final HttpServletResponse response)
      throws ServletException, IOException {
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    final HttpSession hSession = request.getSession(true);
    final String op = request.getParameter(AjaxRequest.OP.toString());
    final boolean skipSessionUserCheck = op != null
        && (op.equals(AjaxOperation.REGISTER.toString())
        || op.equals(AjaxOperation.FIRST_LOAD.toString()));
    if (hSession.isNew()) {
      // they should have gotten a session from the index page.
      // they probably don't have cookies on.
      returnError(response.getWriter(), ErrorCode.NO_SESSION);
    } else if (!skipSessionUserCheck && hSession.getAttribute(SessionAttribute.USER) == null) {
      returnError(response.getWriter(), ErrorCode.NOT_REGISTERED);
    } else if (hSession.getAttribute(SessionAttribute.USER) != null
        && !(((User) hSession.getAttribute(SessionAttribute.USER)).isValid())) {
      // user probably pinged out
      hSession.invalidate();
      returnError(response.getWriter(), ErrorCode.SESSION_EXPIRED);
    } else {
      try {
        handleRequest(request, response, hSession);
      } catch (final AssertionError ae) {
        getServletContext().log(ae.toString());
        ae.printStackTrace();
      }
    }
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
  protected void returnError(final PrintWriter writer, final ErrorCode code) {
    returnError(writer, code, -1);
  }

  /**
   * Return an error to the client.
   * 
   * @param writer
   * @param serial
   */
  @SuppressWarnings("unchecked")
  protected void returnError(final PrintWriter writer, final ErrorCode code, final int serial) {
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
  protected void returnData(final PrintWriter writer, final Map<ReturnableData, Object> data) {
    returnObject(writer, data);
  }

  /**
   * Return multiple response data to the client.
   * 
   * @param writer
   *          Writer for the response.
   * @param data_list
   *          List of key-value data to return as the response.
   */
  protected void returnArray(final PrintWriter writer,
      final List<Map<ReturnableData, Object>> data_list) {
    returnObject(writer, data_list);
  }

  private void returnObject(final PrintWriter writer, final Object object) {
    final String ret = JSONValue.toJSONString(object);
    writer.println(ret);
    //    System.out.println(ret);
  }

  protected Injector getInjector() {
    return (Injector) getServletContext().getAttribute(StartupUtils.INJECTOR);
  }
}
