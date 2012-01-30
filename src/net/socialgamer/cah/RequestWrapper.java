package net.socialgamer.cah;

import javax.servlet.http.HttpServletRequest;

import net.socialgamer.cah.Constants.AjaxRequest;


public class RequestWrapper {
  private final HttpServletRequest request;

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

  public String getRemoteAddr() {
    return request.getRemoteAddr();
  }

  public String getRemoteHost() {
    return request.getRemoteHost();
  }
}
