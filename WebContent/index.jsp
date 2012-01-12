<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Cards Against Humanity</title>
<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="js/cah.js"></script>
<%-- cah must be first, ajax must be before app. app probably has to be last. --%>
<%-- TODO make this be dynamic with looking at the filesystem and using jquery --%>
<script type="text/javascript" src="js/cah.log.js"></script>
<script type="text/javascript" src="js/cah.longpoll.js"></script>
<script type="text/javascript" src="js/cah.longpoll.handlers.js"></script>
<script type="text/javascript" src="js/cah.ajax.js"></script>
<script type="text/javascript" src="js/cah.ajax.builder.js"></script>
<script type="text/javascript" src="js/cah.ajax.handlers.js"></script>
<script type="text/javascript" src="js/cah.app.js"></script>
<link rel="stylesheet" type="text/css" href="cah.css" media="screen" />
</head>
<body>
<% HttpSession hSession = request.getSession(true); %>
<%--
< % = new net.socialgamer.cah.data.WhiteDeck().getNextCard().toString() % >
--%>

<div id="nickbox">
    Nickname: <input type="text" id="nickname" value="" maxlength="30" />
    <input type="button" id="nicknameconfirm" value="Set" />
    <span id="nickbox_error" class="error"></span>
</div>

<div id="canvass">
  <input type="button" id="logout" value="Log out" />
  <div id="chat_area">
    <div id="log"></div>
    <input type="text" id="chat" maxlength="200" />
    <input type="button" id="chat_submit" value="Chat" />
  </div>
</div>

</body>
</html>
