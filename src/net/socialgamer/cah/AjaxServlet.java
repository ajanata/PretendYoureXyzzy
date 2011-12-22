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

import com.google.inject.Guice;
import com.google.inject.Injector;


/**
 * Servlet implementation class AjaxServlet
 * 
 * This servlet is only used for client actions, not for long-polling.
 */
@WebServlet("/AjaxServlet")
public class AjaxServlet extends CahServlet {
  private static final long serialVersionUID = 1L;

  private final Injector injector;

  private final Server server;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public AjaxServlet() {
    super();

    injector = Guice.createInjector();
    this.server = injector.getInstance(Server.class);
  }

  /**
   * @see Servlet#init(ServletConfig)
   */
  @Override
  public void init(final ServletConfig config) throws ServletException {
    // TODO Auto-generated method stub
  }

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
    final Map<String, Object> data = handler.handle(request.getParameterMap(), hSession);
    data.put("serial", serial);
    returnData(out, data);
    return;
  }

}
