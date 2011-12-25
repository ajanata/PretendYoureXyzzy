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

  /**
   * @see HttpServlet#HttpServlet()
   */
  public AjaxServlet() {
    super();

    injector = Guice.createInjector();
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
        returnError(out, "bad_req", "Bad request");
        return;
      }
    }

    final String op = request.getParameter("op");
    //  !Handlers.LIST.containsKey(op)
    if (op == null || op.equals("")) {
      returnError(out, "op_not_spec", "Operation not specified.", serial);
      return;
    }

    final Handler handler;
    try {
      handler = injector.getInstance(Handlers.LIST.get(op));
    } catch (final Exception e) {
      returnError(out, "bad_op", "Invalid operation.", serial);
      return;
    }
    final Map<String, Object> data = handler.handle(request.getParameterMap(), hSession);
    data.put("serial", serial);
    returnData(out, data);
    return;
  }

}
