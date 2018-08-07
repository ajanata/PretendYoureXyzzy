<%--
Copyright (c) 2012, Andy Janata
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted
provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions
  and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of
  conditions and the following disclaimer in the documentation and/or other materials provided
  with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--%>
<%--
A simple stats page. Outputs the number of connected users and active game lobbies. This is intended
to be used with a script for munin. This is instantaneous usage, so it will not necessarily be the
most useful graph if it is only updated every 15 minutes, but it is still nice to have.

@author Andy Janata (ajanata@socialgamer.net)
--%>
<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Properties" %>
<%@ page import="com.google.inject.Injector" %>
<%@ page import="net.socialgamer.cah.data.ConnectedUsers" %>
<%@ page import="net.socialgamer.cah.data.GameManager" %>
<%@ page import="net.socialgamer.cah.StartupUtils" %>
<%
ServletContext servletContext = pageContext.getServletContext();
Injector injector = (Injector) servletContext.getAttribute(StartupUtils.INJECTOR);

ConnectedUsers users = injector.getInstance(ConnectedUsers.class);
GameManager games = injector.getInstance(GameManager.class);
Properties props = injector.getInstance(Properties.class);

out.clear();
out.println("USERS " + users.getUsers().size());
out.println("GAMES " + games.getGameList().size());
out.println("MAX_USERS " + props.get("pyx.server.max_users"));
out.println("MAX_GAMES " + props.get("pyx.server.max_games"));
out.println("GLOBAL_CHAT_ENABLED " + props.get("pyx.server.global_chat_enabled"));
out.println("GAME_CHAT_ENABLED " + props.get("pyx.server.game_chat_enabled"));
out.println("BLANK_CARDS_ENABLED " + props.get("pyx.server.allow_blank_cards"));
out.println("METRICS_GAME_ENABLED " + props.get("pyx.metrics.game.enabled"));
out.println("METRICS_ROUND_ENABLED " + props.get("pyx.metrics.round.enabled"));
out.println("METRICS_SESSION_ENABLED " + props.get("pyx.metrics.session.enabled"));
out.println("METRICS_USER_ENABLED " + props.get("pyx.metrics.user.enabled"));
%>
