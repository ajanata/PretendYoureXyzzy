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

  /**
   * Minimum amount of time before timing out and returning a no-op, in nanoseconds.
   */
  private static final long TIMEOUT_BASE = 60 * 1000 * 1000;

  /**
   * Randomness factor added to minimum timeout duration, in nanoseconds. The maximum timeout delay
   * will be TIMEOUT_BASE + TIMEOUT_RANDOMNESS.
   */
  private static final double TIMEOUT_RANDOMNESS = 20 * 1000 * 1000;

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

    final long start = System.nanoTime();
    // Pick a random timeout point between TIMEOUT_BASE and TIMEOUT_BASE + TIMEOUT_RANDOMNESS
    // nanoseconds from now.
    final long end = start + TIMEOUT_BASE + (long) (Math.random() * TIMEOUT_RANDOMNESS);
    final User user = (User) hSession.getAttribute("user");
    assert (user != null);
    user.contactedServer();
    // TODO we might have to synchronize on the user object?
    while (!(user.hasQueuedMessages()) && System.nanoTime() < end) {
      try {
        user.waitForNewMessageNotification((end - System.nanoTime()) / 1000);
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
