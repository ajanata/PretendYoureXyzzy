<?xml version="1.0" encoding="UTF-8" ?>
<%--
Copyright (c) 2012-2018, Andy Janata
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
<link rel="stylesheet" type="text/css" href="cah.css" media="screen" />
</head>
<body>
<div id="tweetbox">
  <h3>Recent tweets (mainly server status updates)</h3>
  <a class="twitter-timeline" data-height="500" data-dnt="true" data-theme="light"
  href="https://twitter.com/_PYX_?ref_src=twsrc%5Etfw">Tweets by _PYX_</a>
  <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
</div>
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
  <li>1 June 2018:<ul>
    <li>Play history links are now provided for users and games. Assuming you have not opted out
    from persistent play history logging and still have your persistent ID cookie, you can view
    every game you've played on the device you are connecting from since the beginning of March.
    Regardless of opting out or not, you can view every game you've played in the current session,
    or every round in a game, with the links provided when you log in or join a game.</li>
  </ul></li>
  <li>5 April 2018:<ul>
    <li>Bugfixes from last week's release (most notably, no more "undefined" before your name if you
    reload the page).</li>
    <li>Minor updates to the chat filter settings to make it less strict, and an additional chat
    filter (you cannot use the same word too many times in the same message).</li>
    <li>Back-end support for other features which will be enabled soon.</li>
  </ul></li>
  <li>27 March 2018:<ul>
    <li>You may now provide a password-like identification code when connecting to positively
    identify yourself and make it difficult for someone to impersonate you. Details are on
    <a href="https://github.com/ajanata/PretendYoureXyzzy/wiki/Identification-Codes">the GitHub
    wiki.</a><ul>
      <li><strong>This is optional, and if you choose to not do so, everything will work the same as
      it always has.</strong></li>
      <li><strong>Do not use a password you use on any other site.</strong></li>
      <li>The value you enter in the identification code box will be combined with your username
      and a server secret and converted into an 11 character verification code.</li>
      <li>Users that have an verification code will have a + in front of their name in chat.
      Hover your mouse over their message to see their 11 character verification code.</li>
      <li>You may also use the <span style="font-family:monospace">/whois</span> command in the chat
      to view information about a user, including their 11 character verification code.</li></ul></li>
    <li>Images on CardCast cards is now supported in a safe manner. Cards will need updated to work
    with this format. Information on how to use it is on the
    <a href="https://github.com/ajanata/PretendYoureXyzzy/wiki/Cardcast#images-on-cards">GitHub
    wiki.</a></li>
    <li><strong>Automatic chat moderation has been added.</strong> This is fairly crude, and limits
    the following behavior:<ul>
      <li>(Global only, if enabled) Messages may not contain large amounts of non-Latin characters
      (emoji spam, etc.).</li>
      <li>(Global only, if enabled) CAPS LOCK IS NOT ALLOWED EITHER.</li>
      <li>(Global only, if enabled) Once your message is a certain length, you have to actually use
      multiple words.</li>
      <li>Global and game chats now have different messages-per-unit-time settings and counters.
      </li>
      <li>You may not repeat the same message multiple times in a row.</li>
      <li>Certain characters and words will cause a message to be silently dropped (that is, instead
      of returning an error message to the person who typed it like all of the previous things will,
      the server will just ignore the message altogether so that user does not know their message
      was ignored). There are currently two things on this list, and no, I'm not telling you what
      they are, and no, they're not actually in Git either.</li>
    </ul></li>
  </ul></li>
  <li>1 March 2018:<ul>
    <li>Added reconnection to the card database server after it restarts. This really should have
    been done years ago... This is what caused all of the errors while trying to start a game with
    locally-stored decks.</li>
    <li>The "view cards" page has been re-enabled.</li>
    <li>Full games sort to the bottom of the game list.</li>
    <li>Added more metrics logging. Sounds boring, but it's important for the long-term viability
    of these servers.</li>
    <li>All official CAH cards through Q3 2017 have been added, and deck names and contents have
    been shuffled accordingly. Any cards not currently in any official decks are now removed.
    The PAX panel sets have also been removed.</li>
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
  <a href="https://github.com/ajanata/PretendYoureXyzzy/issues/new">open a bug on GitHub</a> with a
  screenshot and the name and version of the browser you are using, and I'll try to fix it.
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
      hard to read, and cards overlap (and underlap) your hand, and are hard to click sometimes.
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
</ul>
<p>
  If the game seems to be in a weird state, refresh the page and it should take you back to where
  you were. It would be helpful to take a screenshot and include it in a
  <a href="https://github.com/ajanata/PretendYoureXyzzy/issues/new">new bug on GitHub</a> along with
  a general description of the problem and the time that it happened (include a time zone please!).
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
