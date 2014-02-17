<?xml version="1.0" encoding="UTF-8" ?>
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
Index page. This is currently entirely static HTML, but may eventually require some server-side code
to, for instance, display the number of connected players.

@author Andy Janata (ajanata@socialgamer.net)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Pretend You're Xyzzy</title>
<jsp:include page="analytics.jsp" />
</head>
<body>
<h1>
  Pretend You're <dfn style="border-bottom: 1px dotted black"
  title="Xyzzy is an Artificial Unintelligence bot. You'll be making more sense than him in this game.">
  Xyzzy</dfn>
</h1>
<h3>A Cards Against Humanity clone.</h3>
<p>
  This webapp is still in development. There will be bugs, but hopefully they won't affect gameplay
  very much. To assist with development, <strong>all traffic on this server <em>may</em> be
  logged.</strong>
</p>
<p>
  The name you enter and your computer's IP address will <strong>always</strong> be logged when you
  load the game client. Chat and gameplay may also be logged.
</p>
<p>Recent Changes:</p>
<ul>
  <li>17 February 2014:<ul>
    <li>Some minor bugfixes, including one which should prevent the entire server from dying if a
    single background task gets stuck.</li>
    <li>Some minor performance improvements.</li>
    <li><a href="http://houseofcardsagainsthumanity.com/">House of Cards Against Humanity</a> has
    been entered and will be enabled during a low-traffic period in the next few days.</li>
  </ul></li>
  <li>26 January 2014:<ul>
    <li>Several bugs have been fixed:<ul>
      <li><strong>Games should no longer reset when an idle player is kicked.</strong></li>
      <li>The judge should no longer have to re-judge when a player leaves during judging.</li>
      <li>The playing field should no longer visibly blank out when a player joins or leaves.</li>
    </ul></li>
    <li>The game host has a "stop game" button. If this is abused, it may be changed to only work
    in the first few rounds of a game.</li>
    <li>You can filter which games to display based on what card sets they are using. Under the
    Game List Filters tab, you can assign each card set to one of three statuses: Banned, Neutral,
    and Required. If a game uses <strong>any</strong> of your banned sets, it will not be shown. If
    a game does not use <strong>all</strong> of your required sets, it also will not be shown.</li>
  </ul></li>
  <li>22 December 2013:<ul>
    <li>What I have received so far of the Holiday Bullshit has been added. I will continue to add
    cards to this as I receive them.</li>
    <li>Several custom card sets have been added.</li>
    <li><strong>No further custom card sets will be accepted.</strong> Minor updates to existing
    ones may still be submitted, but I do not guarantee I will get to it in a timely manner. It is
    taking too much of my time to administer the custom cards sets; I'd rather focus the time on
    implementing a way for players to manage card sets in the game by themselves.</li>
    <li>Fixed a memory leak introduced in the last update that causes the server to massively slow
    down after a few days of running.</li>
  </ul></li>
  <li>1 December 2013 Mega-Update:<ul>
    <li>There are a <strong>lot</strong> of new things this time around. You can view the
    <a href="https://github.com/ajanata/PretendYoureXyzzy/commits/master">GitHub commit history</a>
    for full details, but here's a summary:<ul>
      <li>Spectator mode. The host can pick how many spectators the shall allow. Spectators do not
      participate in the game at all, even as Card Czar.</li>
      <li>Fill-in-the-blank White Cards. The host can pick how many of these to shuffle into the
      deck, and when they are played, you are prompted for the text to put on the card.</li>
      <li>/me chat command for emotes.</li>
      <li>Option to disable bouncy cards. We've all had a problem selecting the last card on the
      line; well now, you can uncheck a box up at the top right and they'll stop bouncing around.</li>
      <li>/sync chat command to re-sync the current game state without reloading the page. It should
      be harder to de-sync the client now, as well.</li>
      <li>Users are removed from the server if they have not done anything for an hour.</li>
      <li>Several more bug fixes and back-end improvements.</li>
    </ul></li>
    <li>The Fourth Expansion is up.</li>
    <li>As you have probably noticed in getting here, there is now a meta-lobby which allows you to
    choose between multiple servers. They should be identical other than the people playing on them:
    they are backed by the same card database.</li>
  </ul></li>
  <li>5 September 2013:<ul>
    <li tabindex="0">The Box Expansion and PAX Prime 2013 cards have been added. <strong>If you have
    any spares of these card numbers and are willing to part with them, it would be awesome if you'd
    <a href="mailto:ajanata@socialgamer.net?subject=13PAX+cards">email me</a> and send them to me,
    as I was unable to acquire them at PAX:</strong> 29, 30, 33, 34, 35, 36, 37</li>
  </ul></li>
  <li><a href="changelog.html">Older entries.</a></li>
</ul>
<p>Known issues:</p>
<ul>
  <li><strong>Do not open the game more than once in the same browser.</strong> Neither instance
  will receive all data from the server, and you will not be able to play. I have an idea on how to
  fix this, but I haven't had time to do so.</li>
  <li>This game was extensively tested in <a href="http://google.com/chrome">Google Chrome</a>.
  It should work in all recent versions of major browsers, but it may not look 100% as intended. If
  you find a major issue, please
  <a href="mailto:ajanata@socialgamer.net?subject=PYX%20bug">email me</a> with a screenshot and the
  name and version of the browser you are using, and I'll try to fix it.
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
  <li>Played cards seem to blank when someone joins or leaves. You may have to refresh the page
  to see the cards again if you're the Card Czar.</li>
</ul>
<p>Current limitations:</p>
<ul>
  <li>Support for Black Cards with "pick" and/or "draw" annotations is rudimentary. When you play
  your cards, it does not group them until the judging starts. Also, when other players play cards,
  you do not see any progress from them until they have played all 2 or 3 cards, and it only shows
  a single face-down card for them. I will try to make this look nicer, but it works.
	  <ul>
	    <li>Also, you cannot un-do your first (or second) card: Once it's played, it's played.</li>
	    <li>While judging, only one card will be highlighted. It does not matter which card in a group
	    you click, the game will figure it out.</li>
	    <li>I know that when you have a lot of players, especially with Pick 2 or Pick 3, it gets very
      hard to read, and cards overlap (and underlap) your hard, and are hard to click sometimes.
      I'll work on this soon. You can resize the window to try to help if you're having problems
      for now.</li>
	  </ul>
  </li>
  <li>You can't bet Awesome Points to play another card, and I am unsure if I will add this.</li>
</ul>
<p>Future enhancements:</p>
<ul>
  <li>There may be an option to display who played every card.</li>
  <li>A registration system and long-term statistics tracking may be added at some point.</li>
  <li>Support for custom Black and White cards will also likely be added, with a game host option to
  use them or just the stock cards.</li>
</ul>
<p>
  If the game seems to be in a weird state, refresh the page and it should take you back to where
  you were. It would be helpful to take a screenshot and
  <a href="mailto:ajanata@socialgamer.net?subject=PYX%20bug">email it to me</a> along with a general
  description of the problem and the time that it happened (include a time zone please!).
</p>
<p>
  <input type="button" value="I have read the above; Take me to the game!"
    onclick="window.location='game.jsp';" />
</p>
<p>
  Pretend You're Xyzzy is a Cards Against Humanity clone, which is available at
  <a href="http://www.cardsagainsthumanity.com/">cardsagainsthumanity.com</a>, where you can buy it
  or download and print it out yourself. It is distributed under a
  <a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons - Attribution -
  Noncommercial - Share Alike license</a>. This web version is in no way endorsed or sponsored by
  cardsagainsthumanity.com. You may download the source code to this version from
  <a href="https://github.com/ajanata/PretendYoureXyzzy">GitHub</a>. For full license
  information, including information about included libraries, see the
  <a href="license.html">full license information</a>.
</p>
</body>
</html>
