/**
 * Copyright (c) 2012-2018, Andy Janata
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

package net.socialgamer.cah.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.inject.Injector;
import com.google.inject.Key;

import net.socialgamer.cah.CahModule.BroadcastConnectsAndDisconnects;
import net.socialgamer.cah.CahModule.CookieDomain;
import net.socialgamer.cah.CahModule.GameChatEnabled;
import net.socialgamer.cah.CahModule.GlobalChatEnabled;
import net.socialgamer.cah.CahModule.InsecureIdAllowed;
import net.socialgamer.cah.StartupUtils;


@WebServlet("/js/cah.config.js")
public class JavascriptConfigServlet extends HttpServlet {

  private static final long serialVersionUID = 4287566906479434127L;

  private String configString;

  @Override
  public void init(final ServletConfig config) throws ServletException {
    final StringBuilder builder = new StringBuilder(256);
    //TODO: these should be loadable from the web.xml
    builder.append("cah.DEBUG = false;\n");
    builder.append("cah.SILENT_DEBUG = false;\n");

    String contextPath = config.getServletContext().getContextPath();
    if (!contextPath.endsWith("/")) {
      contextPath += "/";
    }
    builder.append(String.format("cah.AJAX_URI = '%sAjaxServlet';\n", contextPath));
    builder.append(String.format("cah.LONGPOLL_URI = '%sLongPollServlet';\n", contextPath));

    configString = builder.toString();

    super.init(config);
  }

  @Override
  protected void doGet(final HttpServletRequest req, final HttpServletResponse resp)
      throws ServletException, IOException {

    // We have to do this every time since these come from the properties file and that can change...
    final StringBuilder builder = new StringBuilder(256).append(configString);
    // Ideally we'd figure out how to make this Servlet itself injectable but I don't have time.
    final Injector injector = (Injector) getServletContext().getAttribute(StartupUtils.INJECTOR);
    final String cookieDomain = injector.getInstance(Key.get(String.class, CookieDomain.class));
    final Boolean globalChatEnabled = injector.getInstance(Key.get(Boolean.class, GlobalChatEnabled.class));
    final Boolean gameChatEnabled = injector
        .getInstance(Key.get(Boolean.class, GameChatEnabled.class));
    final Boolean insecureIdAllowed = injector
        .getInstance(Key.get(Boolean.class, InsecureIdAllowed.class));
    final Boolean broadcastingUsers = injector
        .getInstance(Key.get(Boolean.class, BroadcastConnectsAndDisconnects.class));
    builder.append(String.format("cah.COOKIE_DOMAIN = '%s';\n", cookieDomain));
    builder.append(String.format("cah.GLOBAL_CHAT_ENABLED = %b;\n", globalChatEnabled));
    builder.append(String.format("cah.GAME_CHAT_ENABLED = %b;\n", gameChatEnabled));
    builder.append(String.format("cah.INSECURE_ID_ALLOWED = %b;\n", insecureIdAllowed));
    builder.append(String.format("cah.BROADCASTING_USERS = %b;\n", broadcastingUsers));

    resp.setContentType("text/javascript");
    final PrintWriter out = resp.getWriter();
    out.println(builder.toString());
    out.flush();
    out.close();
  }
}
