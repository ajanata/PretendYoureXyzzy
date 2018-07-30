package net.socialgamer.cah.servlets;

import org.json.JSONObject;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author Gianlu
 */
@WebServlet("/ServerAlive")
public class ServerAliveServlet extends HttpServlet {

  public ServerAliveServlet() {
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    JSONObject obj = new JSONObject();
    obj.put("token", ServerIsAliveTokenHolder.get());
    resp.getWriter().write(obj.toString());
  }
}
