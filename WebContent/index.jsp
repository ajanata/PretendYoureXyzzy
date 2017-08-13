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
  <li>13 August 2017:<ul>
    <li><strong>Global chat is disabled.</strong> Far too spammy, far too shitty. Go shitpost
    somewhere else, or at least take it to a game chat.</li>
    <li>Added metrics logging. This will allow analysis over what cards are played often, and
    regional trends. See the next bullet point for details. Your username and chat will
    <strong>never</strong> be stored permanently.</li>
    <li><a href="privacy.html"><strong>Hey, this is important:</strong> Read the privacy page for
    details about what gameplay information is collected and how it's shared.</a></li>
  </ul></li>
  <li>3 May 2015:<ul>
    <li>The game list automatically updates once per minute now, instead of several times per
    second. You can still click the Refresh Games button in the top left corner at any time.</li>
    <li>Chat flood protection has been made more strict.</li>
    <li>Other back-end changes to attempt to get the AWS bill in control.</li>
    <li><strong>All locally-stored custom card sets have been removed.</strong> You must use
    Cardcast for custom card sets now.</li>
    <li>The 5th and 6th Expansions, PAX Prime 2014 Panel, 10 Days or Whatever of Kwanzaa,
    and Science packs have all been added.</li>
  </ul></li>
  <li>21 February 2015:<ul>
    <li>Servers now run in Amazon Web Services. This is going to cost me more, but at least it
    should be more stable and not take down my other stuff when it does go down...<ul>
      <li>I am still tweaking server settings in AWS. It likely is going to be unstable for another
      week or two while I fine-tune cost and performance.</li></ul></li>
    <li>Card set filters are fixed.</li>
    <li><pre>/removecardcast</pre> is fixed.</li>
    <li>Connect and disconnect notices are disabled server-wide. This was a major source of
    bandwidth and processing time.</li>
    <li><strong>You can start a game without using any local card sets.</strong>You must have at
    least 50 black cards and (20 times player limit) white cards to be able to start a game.</li>
    <li>Several other back-end performance and code maintainability improvements.</li>
    <li><strong>Custom card sets will be removed from local storage in the near future.</strong>You
    will have to use Cardcast to use custom card sets. If a card set you want is not already in
    Cardcast, you can attempt to extract it from
    <a href='https://github.com/ajanata/PretendYoureXyzzy/blob/737b468/cah_cards.sql'>the last
    version of the database dump which contains them</a> and add it to Cardcast yourself; I will be
    unable to provide help in doing so.</li>
    <li>At roughly the same time, all officially released Cards Against Humanity sets which are not
    already in the system will be added as local decks.</li>
    <li>Remaining known issues and high priority features:<ul>
      <li>Leaving a game as a spectator doesn't work right.</li>
      <li>Game owners still can't kick players from their game.</li>
      <li>Actually saw a deadlock the other night, so that needs fixed.</li>
    </ul></li>
  </ul></li>
  <li>11 August 2014:<ul>
    <li>Loading decks from <a href="http://www.cardcastgame.com/">Cardcast</a> is now supported in a
    preview release. See <a href="https://github.com/ajanata/PretendYoureXyzzy/wiki/Cardcast">the
    wiki</a> for instructions. A better UI will hopefully happen before too long, but you can see
    how long it took to get any sort of custom deck loading implemented...</li>
    <li>Please go make your own card sets there! It's a really cool site.</li>
    <li><strong>If you submitted a card set which is currently hosted locally on PYX, please add it
    to Cardcast and let me know when you have done so, so that I may remove it from the local list
    to de-clutter the page.</strong> I will list Cardcast codes for previously-hosted decks for a
    period of time so that users may continue to find them.</li>
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
