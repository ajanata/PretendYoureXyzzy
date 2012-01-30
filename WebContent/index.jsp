<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Cards Against Humanity</title>
</head>
<body>
<p>
  This webapp is still in development. There will be bugs, but hopefully they won't affect gameplay
  very much. To assist with development, <strong>all traffic on this server <em>may</em> be
  logged.</strong>
</p>
<p>
  The name you enter and your computer's IP address will <strong>always</strong> be logged when you
  load the game client. Chat and gameplay may also be logged.
</p>
<p>Known issues:</p>
<ul>
  <li>This game was extensively tested in <a href="http://google.com/chrome">Google Chrome</a>.
  It should work in all recent versions of major browsers, but it may not look 100% as intended. If
  you find a major issue, please
  <a href="mailto:ajanata@socialgamer.net?subject=Cards%20Against%20Humanity%20bug">email me</a>
  with a screenshot and the name and version of the browser you are using, and I'll try to fix it.
  </li>
  <li>You may not always see your card in the top area after you play it.</li>
  <li>Leaving the game could very easily break the game.</li>
  <li>If you refresh in the game, an error will pop up in the log briefly before the refresh
  happens. It is safe to ignore.</li>
  <li>Elements may not be perfectly sized and positioned immediately after loading the page if your
  window is sufficiently small. Resize the window to fix.</li>
</ul>
<p>Current limitations:</p>
<ul>
  <li>Support for Black Cards with "pick" and/or "draw" annotations is not implemented. These cards
  are skipped entirely at the moment.</li>
  <li>All games and the main lobby share the same chat.</li>
  <li>There is no play timer to keep the game moving if one person goes idle. However, if their
  browser crashes or they lose connection, they will be removed from the game after approximately 3
  minutes.</li>
</ul>
<p>
  If the game seems to be in a weird state, refresh the page and it should take you back to where
  you were. It would be helpful to take a screenshot and
  <a href="mailto:ajanata@socialgamer.net?subject=Cards%20Against%20Humanity%20bug">email it to
  me</a> along with a general description of the problem and the time that it happened (include a
  time zone please!).
</p>
<p>
  <input type="button" value="I have read the above; Take me to the game!"
    onclick="window.location='game.jsp';" />
</p>
</body>
</html>