package net.socialgamer.cah;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.socialgamer.cah.db.BlackCard;
import net.socialgamer.cah.db.WhiteCard;

import org.apache.commons.lang3.StringEscapeUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;


/**
 * Servlet implementation class TestServlet
 */
@WebServlet({ "/TestServlet" })
public class TestServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  private SessionFactory sessionFactory;

  @Override
  public void init() {
    sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
   */
  @Override
  protected void doGet(final HttpServletRequest request, final HttpServletResponse response)
      throws ServletException, IOException {
    // response.setCharacterEncoding("UTF-8");
    final PrintWriter out = response.getWriter();
    // ServletOutputStream out = response.getOutputStream();
    final Session session = sessionFactory.openSession();
    @SuppressWarnings("unchecked")
    final List<BlackCard> b = session.createQuery("from BlackCard order by random()").list();
    for (final BlackCard bc : b) {
      out.println(StringEscapeUtils.escapeHtml4(bc.toString()));
    }

    out.println("\n\n\n");
    @SuppressWarnings("unchecked")
    final List<WhiteCard> w = session.createQuery("from WhiteCard order by random()").list();
    for (final WhiteCard wc : w) {
      out.println(StringEscapeUtils.escapeHtml4(wc.toString()));
    }

    // Transaction t = session.beginTransaction();
    // @SuppressWarnings("unchecked")
    // Game g = new Game((List<BlackCard>)b, (List<WhiteCard>)w);
    // session.persist(g);
    // t.commit();

    session.close();
  }

}
