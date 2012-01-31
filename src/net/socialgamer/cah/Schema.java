package net.socialgamer.cah;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.dialect.PostgreSQLDialect;


/**
 * Servlet implementation class Schema
 */
@WebServlet("/Schema")
public class Schema extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
   */
  @Override
  protected void doGet(final HttpServletRequest request, final HttpServletResponse response)
      throws ServletException, IOException {
    final AnnotationConfiguration c = new AnnotationConfiguration();
    c.configure();
    final String[] ls = c.generateSchemaCreationScript(new PostgreSQLDialect());
    final PrintWriter out = response.getWriter();
    for (final String l : ls) {
      out.println(l + ";");
    }
  }
}
