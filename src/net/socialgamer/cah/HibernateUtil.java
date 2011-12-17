package net.socialgamer.cah;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;


public class HibernateUtil {
  public static final HibernateUtil instance = new HibernateUtil();

  public final SessionFactory sessionFactory;

  private HibernateUtil() {
    sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
  }

}
