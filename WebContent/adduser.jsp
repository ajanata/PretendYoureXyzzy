<?xml version="1.0" encoding="UTF-8" ?>
<%--
Copyright (c) 2014, Andy Janata
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
Bootstrapper to add first user accounts. All accounts created this way will be root administrator
accounts by default.

@author Andy Janata (ajanata@socialgamer.net)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.google.inject.Injector" %>
<%@ page import="net.socialgamer.cah.RequestWrapper" %>
<%@ page import="net.socialgamer.cah.StartupUtils" %>
<%@ page import="net.socialgamer.cah.Constants" %>
<%@ page import="net.socialgamer.cah.db.Account" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>

<%
RequestWrapper wrapper = new RequestWrapper(request);
if (!Constants.ADMIN_IP_ADDRESSES.contains(wrapper.getRemoteAddr())) {
  response.sendError(403, "Access is restricted to known hosts");
  return;
}

ServletContext servletContext = pageContext.getServletContext();
Injector injector = (Injector) servletContext.getAttribute(StartupUtils.INJECTOR);

String error = "";
String status = "";

final String save = request.getParameter("save");
final String username = request.getParameter("username");
final String password1 = request.getParameter("password1");
final String password2 = request.getParameter("password2");
final String email = request.getParameter("email");
if ("save".equals(save)
    && null != username && !username.isEmpty()
    && null != password1 && !password1.isEmpty()
    && null != password2 && !password2.isEmpty()
    && password1.equals(password2)) {
  final Session s = injector.getInstance(Session.class);
  // check for existing account
  final Account existingAccount = Account.getAccount(s, username);
  if (null != existingAccount) {
    error = "Username already exists.";
  } else {
    final Transaction t = s.beginTransaction();
    t.begin();
    
    final Account newAccount = new Account();
    newAccount.setUsername(username);
    // FIXME hash password
    newAccount.setPassword(password1);
    newAccount.setEmail(email);
    final Date now = new Date();
    newAccount.setCreated(now);
    newAccount.setLastSeen(now);
    newAccount.setVerifiedPerson(true);
    newAccount.setRoot(true);
    try {
      s.save(newAccount);
      t.commit();
      s.close();
    status = "Created user " + username;
    } catch (Exception e) {
      error = e.getMessage();
      t.rollback();
      s.close();
    }
  }
  
} else if ("save".equals(save)) {
  error = "Username, password1, and password2 are required. Password must match.";
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>PYX - Add Admin Accounts</title>
</head>
<body>
<span style="color:red"><%= error %></span>
<span style="color:blue"><%= status %></span>

<p>Passwords are stored in plain-text right now!</p>
<form method="post" action="adduser.jsp">
<input type="hidden" name="save" value="save" />

<label for="username">Username</label>
<input type="text" name="username" id="username" />

<br/>
<label for="password1">Password</label>
<input type="password" name="password1" id="password1" />

<br/>
<label for="password2">Password (again)</label>
<input type="password" name="password2" id="password2" />

<br/>
<label for="email">Email</label>
<input type="text" name="email" id="email" />

<br/>
<input type="submit" />

</form>
</body>
</html>
