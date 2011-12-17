package net.socialgamer.cah;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.socialgamer.cah.handlers.Handler;
import net.socialgamer.cah.handlers.Handlers;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.google.inject.Guice;
import com.google.inject.Injector;


/**
 * Servlet implementation class AjaxServlet
 * 
 * This servlet is only used for client actions, not for long-polling.
 */
@WebServlet("/AjaxServlet")
public class AjaxServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  private final Injector injector;

  private final Server server;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public AjaxServlet() {
    super();

    this.server = new Server();
    injector = Guice.createInjector(new CahModule(server));
  }

  /**
   * @see Servlet#init(ServletConfig)
   */
  @Override
  public void init(final ServletConfig config) throws ServletException {
    // TODO Auto-generated method stub
  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  @Override
  protected void doPost(final HttpServletRequest request, final HttpServletResponse response)
      throws ServletException, IOException {
    response.setContentType("application/json");
    final PrintWriter out = response.getWriter();

    final HttpSession hSession = request.getSession(true);
    if (hSession.isNew()) {
      // they should have gotten a session from the index page.
      // they probably don't have cookies on.
      returnError(out, "Session not detected. Make sure you have cookies enabled.");
      return;
    }

    int serial = -1;
    if (request.getParameter("serial") != null) {
      try {
        serial = Integer.parseInt(request.getParameter("serial"));
      } catch (final NumberFormatException nfe) {
        returnError(out, "Bad request");
        return;
      }
    }

    final String op = request.getParameter("op");
    if (op.equals("") || !Handlers.LIST.containsKey(op)) {
      returnError(out, "Operation not specified.", serial);
      return;
    }

    final Handler handler;
    try {
      handler = injector.getInstance(Handlers.LIST.get(op));
    } catch (final Exception e) {
      returnError(out, "Invalid operation.", serial);
      return;
    }
    final Map<String, Object> returnData = handler.handle(request.getParameterMap(), hSession);
    returnData.put("serial", serial);
    returnData(out, returnData);
    return;
  }

  private void returnError(final PrintWriter writer, final String message) {
    returnError(writer, message, -1);
  }

  @SuppressWarnings("unchecked")
  private void returnError(final PrintWriter writer, final String message, final int serial) {
    final JSONObject ret = new JSONObject();
    ret.put("error", Boolean.TRUE);
    ret.put("error_message", message);
    writer.println(ret.toJSONString());
  }

  private void returnData(final PrintWriter writer, final Map<String, Object> data) {
    writer.println(JSONValue.toJSONString(data));
  }
}
