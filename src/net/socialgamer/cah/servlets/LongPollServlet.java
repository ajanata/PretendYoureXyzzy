/**
 * Copyright (c) 2012, Andy Janata
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * 
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 *   and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 *   conditions and the following disclaimer in the documentation and/or other materials provided
 *   with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package net.socialgamer.cah.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.LongPollEvent;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.data.QueuedMessage;
import net.socialgamer.cah.data.User;


/**
 * Servlet implementation class LongPollServlet.
 * 
 * This servlet is used for client long polling requests.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
@WebServlet("/LongPollServlet")
public class LongPollServlet extends CahServlet {
  private static final long serialVersionUID = 1L;

  /**
   * Minimum amount of time before timing out and returning a no-op, in nanoseconds.
   */
  private static final long TIMEOUT_BASE = TimeUnit.SECONDS.toNanos(20);
  //  private static final long TIMEOUT_BASE = 10 * 1000 * 1000;

  /**
   * Randomness factor added to minimum timeout duration, in nanoseconds. The maximum timeout delay
   * will be TIMEOUT_BASE + TIMEOUT_RANDOMNESS - 1.
   */
  private static final double TIMEOUT_RANDOMNESS = TimeUnit.SECONDS.toNanos(5);
  //  private static final double TIMEOUT_RANDOMNESS = 0;

  /**
   * The maximum number of messages which will be returned to a client during a single poll
   * operation.
   */
  private static final int MAX_MESSAGES_PER_POLL = 20;

  /**
   * An amount of milliseconds to wait after being notified that the user has at least one message
   * to deliver, before we actually deliver messages. This will allow multiple messages that arrive
   * in close proximity to each other to actually be delivered in the same client request.
   */
  private static final int WAIT_FOR_MORE_DELAY = 50;

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
   */
  @Override
  protected void handleRequest(final HttpServletRequest request,
      final HttpServletResponse response, final HttpSession hSession) throws ServletException,
      IOException {
    final PrintWriter out = response.getWriter();

    final long start = System.nanoTime();
    // Pick a random timeout point between [TIMEOUT_BASE, TIMEOUT_BASE + TIMEOUT_RANDOMNESS)
    // nanoseconds from now.
    final long end = start + TIMEOUT_BASE + (long) (Math.random() * TIMEOUT_RANDOMNESS);
    final User user = (User) hSession.getAttribute(SessionAttribute.USER);
    assert (user != null);
    user.contactedServer();
    while (!(user.hasQueuedMessages()) && System.nanoTime() - end < 0) {
      try {
        user.waitForNewMessageNotification(TimeUnit.NANOSECONDS.toMillis(end - System.nanoTime()));
      } catch (final InterruptedException ie) {
        // pass
      }
    }
    if (user.hasQueuedMessages()) {
      try {
        // Delay for a short while in case there will be other messages queued to be delivered.
        // This will certainly happen in some game states. We want to deliver as much to the client
        // in as few round-trips as possible while not waiting too long.
        Thread.sleep(WAIT_FOR_MORE_DELAY);
      } catch (final InterruptedException ie) {
        // pass
      }
      final Collection<QueuedMessage> msgs = user.getNextQueuedMessages(MAX_MESSAGES_PER_POLL);
      // just in case...
      if (msgs.size() > 0) {
        final List<Map<ReturnableData, Object>> data =
            new ArrayList<Map<ReturnableData, Object>>(msgs.size());
        for (final QueuedMessage qm : msgs) {
          data.add(qm.getData());
        }
        returnArray(user, out, data);
        return;
      }
    }
    // otherwise, return that there is no new data
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
    data.put(LongPollResponse.EVENT, LongPollEvent.NOOP.toString());
    data.put(LongPollResponse.TIMESTAMP, System.currentTimeMillis());
    returnData(user, out, data);
  }
}
