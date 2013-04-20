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
  <li>20 April 2013:<ul>
    <li>A bunch of accessibility things for screen readers. If you are not using a
    screen reader, you don't care about any of this. If you are, more information is available on
    the game page.</li>
  </ul></li>
  <li>14 April 2013:<ul>
    <li>Fixed the game list sometimes showing the same game over and over, and not loading the list
    of card sets to display in game options.</li>
    <li>Made game list cards bigger, and fixed HTML entities displayed in them.</li>
    <li>Fixed even-numbered rows in the scoreboard not using the correct background color when
    displaying that the person won.</li>
  </ul></li>
  <li>13 April 2013:<ul>
    <li>Added client-side option to hide game password in the game options area. This is useful for
    streaming the game and not letting people see the password. ;)</li>
    <li>Added option to "not use" the idle timer. In reality, it just sets it to about 25 days.</li>
    <li>Internal cleanups.</li>
  </ul></li>
  <li>30 March 2013:<ul>
    <li>Increased the game limit to 200.</li>
    <li>Tweaking other settings to attempt to increase stability with more than 550 users.</li>
    <li>Fixed bug where inactive card sets were showing. That was just something stupid on my end.
    </li>
  </ul></li>
  <li>27 March 2013:<ul>
    <li>The Third Expansion and the PAX East packs, as well as a few more custom cards.</li>
    <li>Card sets have a description when you hover over them in the options panel.</li>
    <li>Administrators can send messages that show up in every game chat, so I can do announcements
    that everybody will see.</li>
    <li>Increased the game limit to 125.</li>
  </ul></li>
  <li>25 February 2013:<ul>
    <li>Per-game chats. Finally. Global chat is still there. I hope to make it highlight the tab
    when there is activity at some point.</li>
  </ul></li>
  <li>9 January 2013:<ul>
    <li>New stylesheet from timsookram.</li>
    <li>New card sets. The Holiday Pack was added about a month ago, the MLP pack got lost in the
    server migration and has been restored, and another custom card set has been added from the fine
    folks over at Very Serious. This card set has a decent amount of in-jokes, though, so you may
    want to skip it for now. I'll pull out the universally funny cards later into another set.
      <ul><li>I haven't forgotten about the other card sets that have been sent in. I'll get to
      those later this week. I did this card set first since it was sent to me in a format that I
      could import directly into the database.</li></ul>
    </li>
    <li>Plugged a hole that would let any especially crafty user pretend to be an administrator.
    This was done entirely at the firewall and web server level and required no code change to the
    game itself.</li>
    <li>Increased maximum game limit from 60 to 75.</li>
  </ul></li>
  <li>12 October, 5:00 AM UTC:<ul>
    <li>User Preferences. Click the button in the top-right corner and you can hide the connect
    and quit events, and ignore chat from specific users. These settings are remembered for the
    next time you play the game. The game also remembers what name you used last time you
    played.</li>
    <li>Games without a password will sort before games that do, so you can find them easier.</li>
    <li>Under-the-hood improvements.</li>
  </ul></li>
  <li>Early September, 2012:<ul>
    <li>The Second Expansion has been entered.</li>
  </ul></li>
  <li>29 August, 6:00 AM UTC:<ul>
    <li>Chat flood protection. You may only chat 5 times in any given 15 second period.</li>
    <li>Splitting game chat out will happen next, this was just an easy bandage.</li>
  </ul></li>
  <li>21 August, 6:00 AM UTC:<ul>
    <li>Ban list. Only admins can ban.</li>
    <li>Chat from admins shows up in blue.</li>
    <li>
      Currently, the admin list contains just me and a close friend. I am not taking applications.
    </li>
    <li>Performance and stability tweaks.</li>
  </ul></li>
  <li>7 July, 10:00 PM UTC:<ul>
    <li>Proper Card Set support. Currently, only I can define the cards and card sets, but I hope to
    eventually let users define their own. This leads into the next item...</li>
    <li><strong>The First Expansion</strong>! Sorry it took so long, I've been quite busy with real
    work lately. Whenever The Second Expansion rolls around, it will be much easier for me to add
    since I've put in the proper structure to deal with card sets.</li>
    <li>I still haven't had time to separate out chat per-game, but that is the next thing on the
    to-do list.</li>
  </ul></li>
  <li>15 June, 2:00 AM UTC:<ul>
    <li>I haven't forgotten about this! The First Expansion cards are typed up (you probably have
    seen them accidentally showing up), I just need to make a proper way to choose what card decks
    to use in games. I will try to do that this weekend! In the mean time, I've removed the dummy
    marker cards you've also probably noticed from showing up (and also the First Expansion cards).
    </li>
  </ul></li>
  <li>23 March, 7:00 AM UTC:<ul>
    <li><a href="https://github.com/ajanata/PretendYoureXyzzy/commit/368e890c07d29e1b810821ac6f76c983227ab7c1">
        Fixed a deadlock which caused the server to grind to a halt occasionally.</a> At least, I
    fixed one deadlock. I looked over the code a bit more closely to see if there were any other
    potential deadlocks, and didn't see any. I did go ahead and rework some of the other code to
    make it less likely. Hopefully this will fix the problems with the server randomly crapping
    out.</li>
    <li><a href="https://github.com/ajanata/PretendYoureXyzzy/commit/bc4f0818f18f106e92590c4510210fc28847ef58">
      Fixed the chat log in Opera.</a></li>
  </ul></li>
  <li>19 March, 4:20 AM UTC:<ul>
    <li>Added game passwords.</li>
    <li>Added Show Game Options button in-game to see the game's options. The host cannot change
    options while the game is in progress.</li>
  </ul></li>
  <li>18 March, 6:40 PM UTC:<ul>
    <li>Added version 1.2 Cards Against Humanity cards. Game host can choose between original, new,
    or both at once.<ul>
      <li>Cards that were slightly reworded in the new version were updated instead of replaced
      here, so even if you pick original you may get some newly reworded cards.</li>
    </ul></li>
    <li>Hopefully fixed a rare crashing issue.</li>
  </ul></li>
  <li>17 March, 1:30 AM UTC:<ul>
    <li>Fixed AFK timer skipping people who played at least one card for a multiple-PICK card.</li>
    <li>Increased AFK timeouts to 45 + 15 * PICK seconds and 40 + 7 * PICK * PLAYERS seconds.</li>
  </ul></li>
  <li>17 March, Midnight UTC:<ul>
    <li>Initial AFK timer support added. This will skip (or kick, if there are not enough players) a
    player that takes longer than 15 + 15 * PICK seconds to play, or skip a judge that takes longer
    than 20 + 5 * PICK * PLAYERS seconds to select a winner. If a player is idle for two consecutive
    rounds, they will be kicked from the game. All of these numbers are adjustable; if the timeouts
    are too long or too short, please let me know!</li>
    <li>The game host can specify the Awesome Point goal from 4 to 10.</li>
    <li>The game host can specify the maximum number of players in a game from 3 to 10.</li>
  </ul></li>
</ul>
<p>Known issues:</p>
<ul>
  <li><strong>Do not open the game more than once in the same browser.</strong> Neither instance
  will receive all data from the server, and you will not be able to play. I have an idea on how to
  fix this, but I haven't had time to do so.</li>
  <li>This game was extensively tested in <a href="http://google.com/chrome">Google Chrome</a>.
  It should work in all recent versions of major browsers, but it may not look 100% as intended. If
  you find a major issue, please
  <a href="mailto:ajanata@socialgamer.net?subject=PYZ%20bug">email me</a> with a screenshot and the
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
  <li>All games and the main lobby share the same chat.</li>
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
  <a href="mailto:ajanata@socialgamer.net?subject=PYZ%20bug">email it to me</a> along with a general
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
