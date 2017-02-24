/**
 * Copyright (c) 2012-2017, Andy Janata
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

package net.socialgamer.cah;

import javax.servlet.http.HttpServletRequest;

import net.socialgamer.cah.Constants.AjaxRequest;


/**
 * Wrap around an {@code HttpServletRequest}, to allow parameters to be retrieved by enum value.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class RequestWrapper {
  private final HttpServletRequest request;

  /**
   * Create a new RequestWrapper.
   *
   * @param request
   *          An {@code HttpServletRequest} to wrap around.
   */
  public RequestWrapper(final HttpServletRequest request) {
    this.request = request;
  }

  /**
   * Returns the value of a request parameter as a String, or null if the parameter does not exist.
   *
   * @param parameter
   *          Parameter to get.
   * @return Value of parameter, or null if parameter does not exist.
   */
  public String getParameter(final AjaxRequest parameter) {
    return request.getParameter(parameter.toString());
  }

  /**
   * Returns the value of a request header as a String, or {@code null} if the header does not
   * exist.
   *
   * @param header
   *          Header to get.
   * @return Value of header, or {@code null} if header does not exist.
   */
  public String getHeader(final String header) {
    return request.getHeader(header);
  }

  /**
   * If there is an {@code X-Forwarded-For} header, the <strong>first</strong> entry in that list
   * is returned instead.
   * @see HttpServletRequest#getRemoteAddr()
   */
  public String getRemoteAddr() {
    String addr = request.getHeader("X-Forwarded-For");
    if (null != addr) {
      addr = addr.split(",")[0].trim();
    } else {
      addr = request.getRemoteAddr();
    }
    return addr;
  }
}
