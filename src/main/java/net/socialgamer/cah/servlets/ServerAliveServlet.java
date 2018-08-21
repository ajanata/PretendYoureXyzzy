package net.socialgamer.cah.servlets;

import net.socialgamer.cah.serveralive.ServerAliveConnectionHolder;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.json.JSONTokener;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;

/**
 * @author Gianlu
 */
@WebServlet("/ServerAlive")
public class ServerAliveServlet extends HttpServlet {
  private static final Logger logger = Logger.getLogger(ServerAliveServlet.class);

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    ServerAliveConnectionHolder holder = ServerAliveConnectionHolder.get();
    if (holder == null) {
      logger.warn("ServerAliveConnectionHolder isn't initialized!");
      resp.setStatus(400);
      return;
    }

    JSONObject obj = new JSONObject(new JSONTokener(new InputStreamReader(req.getInputStream())));
    BigInteger nonce = new BigInteger(obj.getString("nonce"), 16);
    byte[] challenge = new BigInteger(obj.getString("challenge"), 16).toByteArray();

    holder.decrypt(nonce, challenge);

    String uuid = new String(challenge);
    resp.getWriter().write(uuid);

    logger.trace("Decoded ServerAlive payload: " + uuid);
    logger.debug(holder);
  }
}
