package net.socialgamer.cah.servlets;

import net.socialgamer.cah.serveralive.ServerAliveConnectionHolder;

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

  public ServerAliveServlet() {
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    ServerAliveConnectionHolder holder = ServerAliveConnectionHolder.get();
    if (holder == null) {
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
    String text = new String(out.toByteArray());
    System.out.println(text);

    resp.getWriter().write("HI!!"); // TODO
  }
}
