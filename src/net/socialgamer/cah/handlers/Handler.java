package net.socialgamer.cah.handlers;

import java.util.Map;

import javax.servlet.http.HttpSession;


/**
 * Implementations of this interface MUST also have a public static final String OP.
 * 
 * @author ajanata
 * 
 */
public interface Handler {
  public Map<String, Object> handle(Map<String, String[]> parameters, HttpSession session);
}
