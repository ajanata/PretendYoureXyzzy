package net.socialgamer.cah.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class JavascriptConfig extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req,
                     HttpServletResponse resp)
              throws ServletException,
                     IOException {

       resp.setContentType("text/javascript");
       PrintWriter out = resp.getWriter();

       //TODO: remove duplicate slashes in urls
       //TODO: include license header?
       //TODO: add no-cache or cache-control headers.
       //TODO: these should be loadable from the web.xml
       //TODO: generate file on startup, then send that.
       out.println("cah.DEBUG = false;");
       out.println("cah.SILENT_DEBUG = false;");

       out.println(String.format("cah.AJAX_URI = \"%s/AjaxServlet\"",req.getContextPath()));
       out.println(String.format("cah.LONGPOLL_URI = \"%s/LongPollServlet\"", req.getContextPath()));

       out.flush(); 
       out.close();

  }

}
