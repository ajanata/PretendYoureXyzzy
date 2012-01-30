package net.socialgamer.cah;

import java.util.Date;
import java.util.Timer;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.servlet.GuiceServletContextListener;


public class StartupUtils extends GuiceServletContextListener {

  public static final String INJECTOR = "injector";

  private static final long PING_START_DELAY = 60 * 1000;

  private static final long PING_CHECK_DELAY = 5 * 1000;

  private static final String PING_TIMER_NAME = "ping_timer";

  public static final String DATE_NAME = "started_at";

  public static final String VERBOSE_DEBUG = "verbose_debug";

  private Date serverStarted;

  @Override
  public void contextDestroyed(final ServletContextEvent contextEvent) {
    final ServletContext context = contextEvent.getServletContext();
    final Timer timer = (Timer) context.getAttribute(PING_TIMER_NAME);
    assert (timer != null);
    timer.cancel();
    context.removeAttribute(PING_TIMER_NAME);
    context.removeAttribute(INJECTOR);
    context.removeAttribute(DATE_NAME);

    super.contextDestroyed(contextEvent);
  }

  @Override
  public void contextInitialized(final ServletContextEvent contextEvent) {
    final ServletContext context = contextEvent.getServletContext();
    final Injector injector = getInjector();
    final UserPing ping = injector.getInstance(UserPing.class);
    final Timer timer = new Timer();
    timer.schedule(ping, PING_START_DELAY, PING_CHECK_DELAY);
    serverStarted = new Date();
    context.setAttribute(PING_TIMER_NAME, timer);
    context.setAttribute(INJECTOR, injector);
    context.setAttribute(DATE_NAME, serverStarted);
  }

  @Override
  protected Injector getInjector() {
    return Guice.createInjector(new CahModule());
  }
}
