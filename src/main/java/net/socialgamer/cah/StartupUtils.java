/**
 * Copyright (c) 2012, Andy Janata
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

import java.io.File;
import java.io.FileReader;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import net.socialgamer.cah.cardcast.CardcastModule;
import net.socialgamer.cah.cardcast.CardcastService;
import net.socialgamer.cah.task.BroadcastGameListUpdateTask;
import net.socialgamer.cah.task.UserPingTask;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.servlet.GuiceServletContextListener;


/**
 * Class with things that need to be done when the servlet context is created and destroyed. Creates
 * and stores a Guice injector, stores the time the server was started, and creates a thread to
 * check for any clients which have stopped responding.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class StartupUtils extends GuiceServletContextListener {

  private static final Logger LOG = Logger.getLogger(StartupUtils.class);

  /**
   * Context attribute key name for the Guice injector.
   */
  public static final String INJECTOR = "injector";

  /**
   * Delay before the disconnected client timer is started when the server starts, in milliseconds.
   */
  private static final long PING_START_DELAY = 60 * 1000;

  /**
   * Delay between invocations of the disconnected client timer, in milliseconds.
   */
  private static final long PING_CHECK_DELAY = 5 * 1000;

  /**
   * Delay before the "update game list" broadcast timer is started, in milliseconds.
   */
  private static final long BROADCAST_UPDATE_START_DELAY = TimeUnit.SECONDS.toMillis(60);

  /**
   * Delay between invocations of the "update game list" broadcast timer, in milliseconds.
   */
  private static final long BROADCAST_UPDATE_DELAY = TimeUnit.SECONDS.toMillis(60);

  /**
   * Context attribute key name for the time the server was started.
   */
  public static final String DATE_NAME = "started_at";

  /**
   * Context attribute key name for whether verbose request and response logging is enabled.
   */
  public static final String VERBOSE_DEBUG = "verbose_debug";

  /**
   * The time the server was started.
   */
  private Date serverStarted;

  @Override
  public void contextDestroyed(final ServletContextEvent contextEvent) {
    final ServletContext context = contextEvent.getServletContext();

    final Injector injector = (Injector) context.getAttribute(INJECTOR);
    final ScheduledThreadPoolExecutor timer = injector
        .getInstance(ScheduledThreadPoolExecutor.class);
    timer.shutdownNow();

    context.removeAttribute(INJECTOR);
    context.removeAttribute(DATE_NAME);

    super.contextDestroyed(contextEvent);
  }

  @Override
  public void contextInitialized(final ServletContextEvent contextEvent) {
    final ServletContext context = contextEvent.getServletContext();
    final Injector injector = getInjector();

    final ScheduledThreadPoolExecutor timer = injector
        .getInstance(ScheduledThreadPoolExecutor.class);

    final UserPingTask ping = injector.getInstance(UserPingTask.class);
    timer.scheduleAtFixedRate(ping, PING_START_DELAY, PING_CHECK_DELAY, TimeUnit.MILLISECONDS);

    final BroadcastGameListUpdateTask broadcastUpdate = injector
        .getInstance(BroadcastGameListUpdateTask.class);
    timer.scheduleAtFixedRate(broadcastUpdate, BROADCAST_UPDATE_START_DELAY,
        BROADCAST_UPDATE_DELAY, TimeUnit.MILLISECONDS);

    serverStarted = new Date();
    context.setAttribute(INJECTOR, injector);
    context.setAttribute(DATE_NAME, serverStarted);

    reconfigureLogging(contextEvent.getServletContext());
    reloadProperties(contextEvent.getServletContext());
    CardcastService.hackSslVerifier();
  }

  public static void reloadProperties(final ServletContext context) {
    LOG.info("Reloading pyx.properties");

    final Injector injector = (Injector) context.getAttribute(INJECTOR);
    final Properties props = injector.getInstance(Properties.class);
    final File propsFile = new File(context.getRealPath("/WEB-INF/pyx.properties"));
    try {
      synchronized (props) {
        props.clear();
        props.load(new FileReader(propsFile));
      }
    } catch (final Exception e) {
      // we should probably do something?
      e.printStackTrace();
    }
  }

  public static void reconfigureLogging(final ServletContext context) {
    LOG.info("Reloading log4j.properties");

    PropertyConfigurator.configure(context.getRealPath(
        "/WEB-INF/log4j.properties"));
  }

  @Override
  protected Injector getInjector() {
    return Guice.createInjector(new CahModule(), new CardcastModule());
  }
}
