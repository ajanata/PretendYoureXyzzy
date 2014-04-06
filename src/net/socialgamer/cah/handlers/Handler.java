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

package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;


/**
 * Implementations of this interface MUST also have a public static final String OP. There will be
 * compile errors if they do not.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public abstract class Handler {

  /**
   * Handle a request.
   * 
   * @param request
   *          The request parameters.
   * @param session
   *          The client's session.
   * @return Response data.
   */
  public abstract Map<ReturnableData, Object> handle(RequestWrapper request,
      HttpSession session);

  /**
   * Get a data set for an error response.
   * 
   * @param errorCode
   *          The error code.
   * @return The data to return as the result of the request.
   */
  protected static Map<ReturnableData, Object> error(final ErrorCode errorCode) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();
    data.put(AjaxResponse.ERROR, Boolean.TRUE);
    data.put(AjaxResponse.ERROR_CODE, errorCode.toString());
    return data;
  }

  /**
   * Clean up after this Handler. Currently, this means using reflection to see if the concrete
   * Handler implementation had a field of type Session (Hibernate), and closing it if it does and
   * did not already close it.
   */
  public final void cleanUp() {
    // this actually breaks stuff, I'll have to think it through later.
    //    for (final Field field : this.getClass().getDeclaredFields()) {
    //      if (field.getType() == Session.class) {
    //        try {
    //          // This Handler had a Hibernate Session. Try to close it if it wasn't already closed.
    //          // This is extremely dirty but also extremely awesome to not have problems if it is
    //          // forgotten.
    //          field.setAccessible(true);
    //          final Session session = (Session) field.get(this);
    //          if (session.isOpen()) {
    //            session.close();
    //            logger.log(Level.INFO, "Closing unclosed Hibernate Session in "
    //                + this.getClass().getName());
    //          }
    //        } catch (final Exception e) {
    //          // Something prevented us from ignoring access control check, so we can't close the
    //          // session. Log about it and continue.
    //          e.printStackTrace();
    //          logger.log(Level.SEVERE, "Unable to reflect and get Hibernate Session from "
    //              + this.getClass().getName());
    //          logger.log(Level.SEVERE, e.toString());
    //        }
    //      }
    //    }
  }
}
