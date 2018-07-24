/**
 * Copyright (c) 2012-2018, Andy Janata
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

package net.socialgamer.cah.servlets;

import com.google.inject.Injector;
import com.google.inject.Key;
import net.socialgamer.cah.CahModule.BroadcastConnectsAndDisconnects;
import net.socialgamer.cah.CahModule.CookieDomain;
import net.socialgamer.cah.CahModule.GlobalChatEnabled;
import net.socialgamer.cah.CahModule.InsecureIdAllowed;
import net.socialgamer.cah.StartupUtils;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;


@WebServlet("/js/cah.config.js")
public class JavascriptConfigServlet extends HttpServlet {
  private static final long serialVersionUID = 4287566906479434127L;
  private String configString;

  @Override
  public void init(final ServletConfig config) throws ServletException {
    final StringBuilder builder = new StringBuilder(256);
    String contextPath = config.getServletContext().getContextPath();
    if (!contextPath.endsWith("/")) contextPath += "/";
    builder.append(String.format("cah.AJAX_URI = '%sAjaxServlet';\n", contextPath));
    builder.append(String.format("cah.LONGPOLL_URI = '%sLongPollServlet';\n", contextPath));
    configString = builder.toString();
    super.init(config);
  }

  @Override
  protected void doGet(final HttpServletRequest req, final HttpServletResponse resp) throws IOException {
    StringBuilder builder = new StringBuilder(256).append(configString);
    Injector injector = (Injector) getServletContext().getAttribute(StartupUtils.INJECTOR);

    String cookieDomain = injector.getInstance(Key.get(String.class, CookieDomain.class));
    builder.append(String.format("cah.COOKIE_DOMAIN = '%s';\n", cookieDomain));
    boolean globalChatEnabled = injector.getInstance(Key.get(Boolean.class, GlobalChatEnabled.class));
    builder.append(String.format("cah.GLOBAL_CHAT_ENABLED = %b;\n", globalChatEnabled));
    boolean insecureIdAllowed = injector.getInstance(Key.get(Boolean.class, InsecureIdAllowed.class));
    builder.append(String.format("cah.INSECURE_ID_ALLOWED = %b;\n", insecureIdAllowed));
    boolean broadcastingUsers = injector.getInstance(Key.get(Boolean.class, BroadcastConnectsAndDisconnects.class));
    builder.append(String.format("cah.BROADCASTING_USERS = %b;\n", broadcastingUsers));

    Properties properties = injector.getInstance(Properties.class);
    builder.append(String.format("cah.DEBUG = %s;\n", properties.getProperty("pyx.client.debug", "false")));
    builder.append(String.format("cah.SILENT_DEBUG = %s;\n", properties.getProperty("pyx.client.silent_debug", "false")));

    resp.setContentType("text/javascript");
    PrintWriter out = resp.getWriter();
    out.println(builder.toString());
    out.flush();
    out.close();
  }
}
