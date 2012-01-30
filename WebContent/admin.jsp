<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="com.google.inject.Injector" %>
<%@ page import="net.socialgamer.cah.StartupUtils" %>
<%@ page import="net.socialgamer.cah.data.ConnectedUsers" %>
<%@ page import="net.socialgamer.cah.data.User" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Date" %>

<%
String remoteAddr = request.getRemoteAddr();
if (!(remoteAddr.equals("0:0:0:0:0:0:0:1") || remoteAddr.equals("127.0.0.1"))) {
  response.sendError(403, "Access is restricted to known hosts");
}

ServletContext servletContext = pageContext.getServletContext();

// process verbose toggle
String verboseParam = request.getParameter("verbose");
if (verboseParam != null) {
  if (verboseParam.equals("on")) {
    servletContext.setAttribute(StartupUtils.VERBOSE_DEBUG, Boolean.TRUE);
  } else {
    servletContext.setAttribute(StartupUtils.VERBOSE_DEBUG, Boolean.FALSE);
  }
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CAH - Admin</title>
<style type="text/css" media="screen">
table, th, td {
  border: 1px solid black;
}

th, td {
  padding: 5px;
}
</style>
</head>
<body>

<%
Injector injector = (Injector) servletContext.getAttribute(StartupUtils.INJECTOR);
%>

<p>
  Server up since
  <%
  Date startedDate = (Date) servletContext.getAttribute(StartupUtils.DATE_NAME);
  long uptime = System.currentTimeMillis() - startedDate.getTime();
  uptime /= 1000l;
  long seconds = uptime % 60l;
  long minutes = (uptime / 60l) % 60l;
  long hours = (uptime / 60l / 60l) % 24l;
  long days = (uptime / 60l / 60l / 24l);
  out.print(String.format("%s (%d hours, %02d:%02d:%02d)",
      startedDate.toString(), days, hours, minutes, seconds));
  %>
</p>

<table>
  <tr>
    <th>Stat</th>
    <th>MiB</th>
  </tr>
  <tr>  
    <td>In Use</td>
    <td><% out.print((Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory()) / 1024 / 1024); %></td>
  </tr>
  <tr>  
    <td>Free</td>
    <td><% out.print(Runtime.getRuntime().freeMemory() / 1024 / 1024); %></td>
  </tr>
  <tr>  
    <td>JVM Allocated</td>
    <td><% out.print(Runtime.getRuntime().totalMemory() / 1024 / 1024); %></td>
  </tr>
  <tr>  
    <td>JVM Max</td>
    <td><% out.print(Runtime.getRuntime().maxMemory() / 1024 / 1024); %></td>
  </tr>
</table>

<%
ConnectedUsers connectedUsers = injector.getInstance(ConnectedUsers.class);
Collection<User> users = connectedUsers.getUsers();
%>
<br/>
<table>
  <tr>
    <th>Username</th>
    <th>Host</th>
  </tr>
  <%
  for (User u : users) {
	  %>
	  <tr>
	    <td><% out.print(u.getNickname()); %></td>
	    <td><% out.print(u.getHostName()); %></td>
	  </tr>
	  <%
  }
  %>
</table>

<%
Boolean verboseDebugObj = (Boolean) servletContext.getAttribute(StartupUtils.VERBOSE_DEBUG); 
boolean verboseDebug = verboseDebugObj != null ? verboseDebugObj.booleanValue() : false;
%>
<p>
  Verbose logging is currently <strong><% out.print(verboseDebug ? "ON" : "OFF"); %></strong>.
  <a href="?verbose=on">Turn on.</a> <a href="?verbose=off">Turn off.</a>
</p>

</body>
</html>
