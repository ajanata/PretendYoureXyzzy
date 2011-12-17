package net.socialgamer.cah;

import net.socialgamer.cah.db.BlackCard;
import net.socialgamer.cah.db.WhiteCard;

import org.apache.commons.lang3.StringEscapeUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class TestServlet
 */
@WebServlet({ "/TestServlet" })
public class TestServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  private SessionFactory sessionFactory;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public TestServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  @Override
  public void init() {
    sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    // TODO Auto-generated method stub
    // response.setCharacterEncoding("UTF-8");
    PrintWriter out = response.getWriter();
    // ServletOutputStream out = response.getOutputStream();
    Session session = sessionFactory.openSession();
    @SuppressWarnings("rawtypes")
    List b = session.createQuery("from BlackCard order by random()").list();
    for (BlackCard bc : (List<BlackCard>) b) {
      out.println(StringEscapeUtils.escapeHtml4(bc.toString()));
    }

    out.println("\n\n\n");
    @SuppressWarnings("rawtypes")
    List w = session.createQuery("from WhiteCard order by random()").list();
    for (WhiteCard wc : (List<WhiteCard>) w) {
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
