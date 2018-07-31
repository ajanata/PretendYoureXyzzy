package net.socialgamer.cah.servlets;

import net.socialgamer.cah.serveralive.ServerAliveConnectionHolder;
import org.apache.log4j.Logger;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

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
      logger.trace("ServerAliveConnectionHolder isn't initialized!");
      resp.setStatus(400);
      return;
    }

    InputStream in = req.getInputStream();
    ByteArrayOutputStream out = new ByteArrayOutputStream();
    byte[] buffer = new byte[4096];
    int read;
    while ((read = in.read(buffer)) != -1) {
      holder.decryptBlock(buffer, read);
      out.write(buffer, 0, read);
    }

    holder.endDecrypt();
    String uuid = new String(out.toByteArray());
    resp.getWriter().write(uuid);

    logger.trace("Decoded ServerAlive payload: " + uuid);
  }
}
