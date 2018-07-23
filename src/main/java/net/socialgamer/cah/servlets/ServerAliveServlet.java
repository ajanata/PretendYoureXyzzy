package net.socialgamer.cah.servlets;

import com.google.inject.Injector;
import net.socialgamer.cah.StartupUtils;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.ServerIsAliveTokenHolder;
import org.json.simple.JSONObject;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Properties;

/**
 * @author Gianlu
 */
@WebServlet("/ServerAlive")
public class ServerAliveServlet extends HttpServlet {
  private final GameManager games;
  private final ConnectedUsers users;
  private final Properties props;

  public ServerAliveServlet() {
    Injector injector = (Injector) getServletContext().getAttribute(StartupUtils.INJECTOR);
    users = injector.getInstance(ConnectedUsers.class);
    games = injector.getInstance(GameManager.class);
    props = injector.getInstance(Properties.class);
  }

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    JSONObject obj = new JSONObject();
    obj.put("token", ServerIsAliveTokenHolder.get());
    obj.put("users", users.getUsers().size());
    obj.put("games", games.getGameList().size());
    obj.put("maxUsers", props.get("pyx.server.max_users"));
    obj.put("maxGames", props.get("pyx.server.max_games"));
    resp.getWriter().write(obj.toJSONString());
  }
}
