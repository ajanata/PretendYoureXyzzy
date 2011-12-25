package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;


/**
 * Implementations of this interface MUST also have a public static final String OP.
 * 
 * @author ajanata
 * 
 */
public abstract class Handler {
  public abstract Map<String, Object> handle(Map<String, String[]> parameters, HttpSession session);

  protected Map<String, Object> error(final String message) {
    final Map<String, Object> data = new HashMap<String, Object>();
    data.put("error", Boolean.TRUE);
    data.put("error_message", message);
    return data;
  }
}
