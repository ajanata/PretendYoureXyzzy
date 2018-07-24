/**
 * Copyright (c) 2012-2017, Andy Janata
 * All rights reserved.
 * <p>
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * <p>
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 * and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 * conditions and the following disclaimer in the documentation and/or other materials provided
 * with the distribution.
 * <p>
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

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Key;
import com.google.inject.servlet.GuiceServletContextListener;
import net.socialgamer.cah.CahModule.ServerStarted;
import net.socialgamer.cah.CahModule.UniqueId;
import net.socialgamer.cah.cardcast.CardcastModule;
import net.socialgamer.cah.cardcast.CardcastService;
import net.socialgamer.cah.metrics.Metrics;
import net.socialgamer.cah.task.BroadcastGameListUpdateTask;
import net.socialgamer.cah.task.ServerIsAliveTask;
import net.socialgamer.cah.task.UserPingTask;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import java.io.FileReader;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;


/**
 * Class with things that need to be done when the servlet context is created and destroyed. Creates
 * and stores a Guice injector, stores the time the server was started, and creates a thread to
 * check for any clients which have stopped responding.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class StartupUtils extends GuiceServletContextListener {

  /**
   * Context attribute key name for the Guice injector.
   */
  public static final String INJECTOR = "injector";
  /**
   * Context attribute key name for the time the server was started.
   */
  public static final String DATE_NAME = "started_at";
  /**
   * Context attribute key name for whether verbose request and response logging is enabled.
   */
  public static final String VERBOSE_DEBUG = "verbose_debug";
  private static final Logger LOG = Logger.getLogger(StartupUtils.class);
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

  public static void reloadProperties(final ServletContext context) {
    final Injector injector = (Injector) context.getAttribute(INJECTOR);
    final Properties props = injector.getInstance(Properties.class);
    reloadProperties(props);
  }

  /**
   * Hack method for calling inside CahModule before the injector is usable.
   */
  public static void reloadProperties(final Properties props) {
    LOG.info("Reloading pyx.properties");

    try {
      synchronized (props) {
        props.clear();
        props.load(new FileReader(ConfigurationHolder.get().getPyxConfig()));
      }
    } catch (final Exception e) {
      // we should probably do something?
      e.printStackTrace();
    }
  }

  public static void reconfigureLogging() {
    LOG.info("Reloading log4j.properties");
    PropertyConfigurator.configure(ConfigurationHolder.get().getLog4JConfig().getAbsolutePath());
  }

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
    reconfigureLogging();
    final Injector injector = getInjector(context);

    final ScheduledThreadPoolExecutor timer = injector
            .getInstance(ScheduledThreadPoolExecutor.class);

    final UserPingTask ping = injector.getInstance(UserPingTask.class);
    timer.scheduleAtFixedRate(ping, PING_START_DELAY, PING_CHECK_DELAY, TimeUnit.MILLISECONDS);

    final BroadcastGameListUpdateTask broadcastUpdate = injector
            .getInstance(BroadcastGameListUpdateTask.class);
    timer.scheduleAtFixedRate(broadcastUpdate, BROADCAST_UPDATE_START_DELAY,
            BROADCAST_UPDATE_DELAY, TimeUnit.MILLISECONDS);

    if (Boolean.valueOf(injector.getInstance(Properties.class).getProperty("pyx.server.discovery_enabled", "false"))) {
      ServerIsAliveTask serverIsAliveTask = injector.getInstance(ServerIsAliveTask.class);
      timer.execute(serverIsAliveTask);
    }

    context.setAttribute(INJECTOR, injector);
    context.setAttribute(DATE_NAME, injector.getInstance(Key.get(Date.class, ServerStarted.class)));

    // this is called in the process of setting up the injector right now... ideally we wouldn't
    // need to do that there and can just do it here again.
    // reloadProperties(context);
    CardcastService.hackSslVerifier();

    // log that the server (re-)started to metrics logging (to flush all old games and users)
    injector.getInstance(Metrics.class).serverStart(
            injector.getInstance(Key.get(String.class, UniqueId.class)));
  }

  protected Injector getInjector(final ServletContext context) {
    return Guice.createInjector(new CahModule(context), new CardcastModule());
  }

  @Override
  protected Injector getInjector() {
    throw new RuntimeException("Not supported.");
  }
}
