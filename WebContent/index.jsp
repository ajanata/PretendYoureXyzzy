<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
	  <ul>
	    <li>That having been said, the chat area doesn't work right at all in Opera. The game still
	    plays properly, but no log messages work. This is rather low on my to-do list as Opera isn't
	    very popular anymore it seems. :(</li>
	  </ul>
  </li>
  <li>You may not always see your card in the top area after you play it, but it has been played.
  Also, sometimes the card will display in the top area but be small. I have no idea why either of
  these happen.</li>
  <li>If you refresh in the game, an error will pop up in the log briefly before the refresh
  happens. It is safe to ignore.</li>
  <li>You may see an error after joining a game. As the error message states, this is safe to
  ignore. I will figure out a way to make this not show up.</li>
  <li>Interface elements may not be perfectly sized and positioned immediately after loading the
  page if your window is sufficiently small. Resize the window to fix.</li>
  <li>A player joining the game in progress may have a slightly incorrect representation of the
  game state until the next round begins.</li>
  <li>Reloading the page when the winning card is displayed does not display the winning card
  again.</li>
  <li>Played cards seem to blank when someone joins (or leaves?). You may have to refresh the page
  to see the cards again if you're the Card Czar.</li>
</ul>
<p>Current limitations:</p>
<ul>
  <li>Support for Black Cards with "pick" and/or "draw" annotations is not implemented. These cards
  are skipped entirely at the moment.</li>
  <li>All games and the main lobby share the same chat.</li>
  <li>There is no play timer to keep the game moving if one person goes idle. However, if their
  browser crashes or they lose connection, they will be removed from the game after approximately 3
  minutes.</li>
  <li>The first player to 8 Awesome Points wins. This is currently hard-coded, but you will be able
  to change it later.</li>
  <li>You can't bet Awesome Points to play another card, and I am unsure if I will add this.</li>
</ul>
<p>Future enhancements:</p>
<ul>
  <li>There will be a button to see the result of the previous round eventually.</li>
  <li>There will be host options to limit the number of players and set the target score soon.</li>
  <li>There will be a timer to keep the game moving if somebody goes afk soon.</li>
  <li>There may be an option to display who played every card.</li>
  <li>There will be improved status information, so it will be easier to tell who is the Card Czar.
  </li>
  <li>A registration system and long-term statistics tracking may be added at some point.</li>
  <li>Support for custom Black and White cards will also likely be added, with a game host option to
  use them or just the stock cards.</li>
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
<p>
  Cards Against Humanity is available at
  <a href="http://www.cardsagainsthumanity.com/">cardsagainsthumanity.com</a>, where you can buy it
  or download and print it out yourself. It is distributed under a
  <a href="http://creativecommons.org/licenses/by-nc-sa/2.0/">Creative Commons - Attribution -
  Noncommercial - Share Alike license</a>. This web version is in no way endorsed or sponsored by
  cardsagainsthumanity.com. You may download the source code to this version from FIXME AFTER
  FIGURING OUT WHAT LICENSE TO USE.
</p>
</body>
</html>
