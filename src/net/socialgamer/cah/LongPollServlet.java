package net.socialgamer.cah;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.socialgamer.cah.data.QueuedMessage;
import net.socialgamer.cah.data.User;


/**
 * Servlet implementation class LongPollServlet
 */
@WebServlet("/LongPollServlet")
public class LongPollServlet extends CahServlet {
  private static final long serialVersionUID = 1L;

  private static final long TIMEOUT = 60 * 1000;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public LongPollServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  @Override
  protected void handleRequest(final HttpServletRequest request,
      final HttpServletResponse response, final HttpSession hSession) throws ServletException,
      IOException {
    final PrintWriter out = response.getWriter();

    final long start = System.currentTimeMillis();
    final User user = (User) hSession.getAttribute("user");
    // TODO we might have to synchronize on the user object?
    while (!(user.hasQueuedMessages()) && start + TIMEOUT > System.currentTimeMillis()) {
      try {
        user.waitForNewMessageNotification(start + TIMEOUT - System.currentTimeMillis());
      } catch (final InterruptedException ie) {
        // I don't think we care?
      }
    }
    if (user.hasQueuedMessages()) {
      final QueuedMessage qm = user.getNextQueuedMessage();
      // just in case...
      if (qm != null) {
        returnData(out, qm.getData());
        return;
      }
    }
    // otherwise, return that there is no new data
    final Map<String, Object> data = new HashMap<String, Object>();
    data.put("event", "noop");
    data.put("timestamp", System.currentTimeMillis());
    returnData(out, data);
  }
}
