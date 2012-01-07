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

    final HttpSession hSession = request.getSession(true);
    final String op = request.getParameter("op");
    final boolean skipSessionUserCheck = op != null
        && (op.equals("register") || op.equals("firstload"));
    if (hSession.isNew()) {
      // they should have gotten a session from the index page.
      // they probably don't have cookies on.
      returnError(response.getWriter(), "no_session",
          "Session not detected. Make sure you have cookies enabled.");
    } else if (!skipSessionUserCheck && hSession.getAttribute("user") == null) {
      returnError(response.getWriter(), "not_registered", "Not registered. Refresh the page.");
    } else {
      handleRequest(request, response, hSession);
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
   * @param message
   *          User-visible error message.
   */
  protected void returnError(final PrintWriter writer, final String code, final String message) {
    returnError(writer, code, message, -1);
  }

  /**
   * Return an error to the client.
   * 
   * @param writer
   * @param message
   * @param serial
   */
  @SuppressWarnings("unchecked")
  protected void returnError(final PrintWriter writer, final String code, final String message,
      final int serial) {
    final JSONObject ret = new JSONObject();
    ret.put("error", Boolean.TRUE);
    ret.put("error_code", code);
    ret.put("error_message", message);
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
  protected void returnData(final PrintWriter writer, final Map<String, Object> data) {
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
  protected void returnArray(final PrintWriter writer, final List<Map<String, Object>> data_list) {
    returnObject(writer, data_list);
  }

  private void returnObject(final PrintWriter writer, final Object object) {
    writer.println(JSONValue.toJSONString(object));
  }

  protected Injector getInjector() {
    return (Injector) getServletContext().getAttribute(StartupUtils.INJECTOR);
  }
}
