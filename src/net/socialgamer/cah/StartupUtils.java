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
