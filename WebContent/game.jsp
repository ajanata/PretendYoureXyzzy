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
The main game page. This is almost entirely static HTML, other than ensuring that a session is
created for the user now.

@author Andy Janata (ajanata@socialgamer.net)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="net.socialgamer.cah.data.GameOptions" %>
<%
// Ensure a session exists for the user.
@SuppressWarnings("unused")
HttpSession hSession = request.getSession(true);
%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Pretend You're Xyzzy</title>
<script type="text/javascript" src="js/jquery-2.1.3.js"></script>
<script type="text/javascript" src="js/jquery-migrate.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/jquery.json.js"></script>
<script type="text/javascript" src="js/QTransform.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/cah.js"></script>
<script type="text/javascript" src="js/cah.config.js"></script>
<%-- cah must be first, ajax must be before app. app probably has to be last. --%>
<%-- TODO make this be dynamic with looking at the filesystem and using jquery --%>
<%-- except that is nontrivial thanks to dependency ordering -_- --%>
<script type="text/javascript" src="js/cah.constants.js"></script>
<script type="text/javascript" src="js/cah.log.js"></script>
<script type="text/javascript" src="js/cah.gamelist.js"></script>
<script type="text/javascript" src="js/cah.card.js"></script>
<script type="text/javascript" src="js/cah.cardset.js"></script>
<script type="text/javascript" src="js/cah.game.js"></script>
<script type="text/javascript" src="js/cah.preferences.js"></script>
<script type="text/javascript" src="js/cah.longpoll.js"></script>
<script type="text/javascript" src="js/cah.longpoll.handlers.js"></script>
<script type="text/javascript" src="js/cah.ajax.js"></script>
<script type="text/javascript" src="js/cah.ajax.builder.js"></script>
<script type="text/javascript" src="js/cah.ajax.handlers.js"></script>
<script type="text/javascript" src="js/cah.app.js"></script>
<script type="text/javascript">
      function changeCSS(cssFile, cssLinkIndex) {
 
        var oldlink = document.getElementsByTagName("link").item(cssLinkIndex);
 
        var newlink = document.createElement("link");
        newlink.setAttribute("rel", "stylesheet");
        newlink.setAttribute("type", "text/css");
        newlink.setAttribute("href", cssFile);
 
        document.getElementsByTagName("head").item(0).replaceChild(newlink, oldlink);
      }
    </script>
<link rel="stylesheet" type="text/css" href="altstyle/default/cah.css" media="screen" />
<link rel="stylesheet" type="text/css" href="stylechooser.css" media="screen" />
<jsp:include page="analytics.jsp" />
</head>
<body>

<div id="welcome">
  <p tabindex="0">Most recent update: 21 February 2015:</p>
  <ul>
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
  </ul>
  <div id="nickbox">
    Nickname:
    <input type="text" id="nickname" class="span3" value="" maxlength="30" placeholder="Xyzzy" role="textbox"
        aria-label="Enter your nickname." />
    <input type="button" class="btn" id="nicknameconfirm" value="Set" />
    <span id="nickbox_error" class="error"></span>
  </div>
  <p></p>
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
</div>

<div id="canvas" class="hide">
  <div id="menubar">
    <div id="menubar_left">
      <input type="button" id="refresh_games" class="hide btn btn-success" value="Refresh Games" />
      <input type="button" id="create_game" class="hide btn btn-primary" value="Create Game" />
      <input type="text" id="filter_games" class="hide search-query" placeholder="Filter games by keyword" />

      <input type="button" id="leave_game" class="hide btn btn-danger" value="Leave Game" />
      <input type="button" id="start_game" class="hide btn btn-success" value="Start Game" />
      <input type="button" id="stop_game" class="hide btn btn-danger" value="Stop Game" />
	 
    </div>
    <div id="menubar_right">
      Current timer duration: <span id="current_timer">0</span> seconds
      <input type="button" class="btn btn-info" id="view_cards" value="View Cards"
          title="Open a new window to view all cards in the game."
          onclick="window.open('viewcards.jsp', 'viewcards');" />
		  
      <input type="button" class="btn btn-danger" id="logout" value="Log out" />
    </div>
  </div>
  <div id="main">
    <div id="game_list" class="hide">
    </div>
    <div id="main_holder">
    </div>
  </div>
</div>
<div id="bottom" class="hide">
  <div id="info_area">
  </div>
  <div id="tabs">
    <ul>
      <li><a href="#tab-preferences" class="tab-button">User Preferences</a></li>
      <li><a href="#tab-gamelist-filters" class="tab-button">Game List Filters</a></li>
      <li><a href="#tab-global" class="tab-button" id="button-global">Global Chat</a></li>
    </ul>
    <div id="tab-preferences">
      <input type="button" class="btn btn-info" value="Save" onclick="cah.Preferences.save();" />
      <input type="button" class="btn btn-warning" value="Revert" onclick="cah.Preferences.load();" />
<div class="dropdown">
<!-- Reference Button :P <input type="button" value="Old Style [ DOES NOT WORK ]" class="btn btn-warning" onclick="changeCSS('oldcah.css', 0);" /> -->
  <button class="lgbtn lbtn-primary dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
    Style Chooser [Beta!]
    <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
    <li role="presentation"><a role="menuitem" onclick="changeCSS('oldcah.css', 0);" tabindex="-1" href="#">Legacy</a></li>
    <li role="presentation"><a role="menuitem" onclick="changeCSS('newcah.css', 0);" tabindex="-1" href="#">New</a></li>
  </ul>
</div>
      <label for="hide_connect_quit">
        <dfn style="border-bottom: 1px dotted black"
          title="Even with this unselected, you might not see these events if the server is configured to not send them.">
            Hide connect and quit events:
        </dfn>
      </label>
      <input type="checkbox" id="hide_connect_quit" />
      <br />
      <label for="ignore_list">Chat ignore list, one name per line:</label>
      <br/>
      <textarea id="ignore_list" style="width: 200px; height: 150px"></textarea>
	  

    </div>
    <div id="tab-gamelist-filters">
      You will have to click Refresh Games after saving any changes here.
      <div style="text-align: right; width:100%">
        <input type="button" value="Save" class="btn btn-primary" onclick="cah.Preferences.save();" />
        <input type="button" value="Revert" class="btn btn-warning" onclick="cah.Preferences.load();" />
      </div>
      <fieldset>
        <legend class="l6g">Card set filters:</legend>
        <div class="cardset_filter_list">
          <span title="Any game which uses at least one of these card sets will not be shown in the game list.">
            Do not show any games with these card sets:
          </span>
          <select id="cardsets_banned" multiple="multiple"></select>
          <div class="buttons">
            <input type="button" class="btn btn-warning" id="banned_remove" value="Remove --&gt;"
              onclick="cah.Preferences.transferCardSets('banned', 'neutral')" />
          </div>
        </div>
        <div class="cardset_filter_list">
          <span>Do not require or ban these card sets:</span>
          <select id="cardsets_neutral" multiple="multiple"></select>
          <div class="buttons">
            <input type="button" id="banned_add" class="btn btn-error" value="&lt;-- Ban"
                onclick="cah.Preferences.transferCardSets('neutral', 'banned')" />
            <input type="button" id="required_add" class="btn btn-primary" value="Require --&gt;"
                onclick="cah.Preferences.transferCardSets('neutral', 'required')" />


	  
          </div>
        </div>
        <div class="cardset_filter_list">
          <span title="Any game that does not use all of these card sets will not be shown in the game list.">
            Only show games with these card sets:
          </span>
          <select id="cardsets_required" multiple="multiple"></select>
          <div class="buttons">
            <input type="button" id="required_remove" class="btn btn-success" value="&lt;-- Remove"
                onclick="cah.Preferences.transferCardSets('required', 'neutral')" />
          </div>
        </div>
      </fieldset>
    </div>
    <div id="tab-global">
      <div class="log"></div>
      <input type="text" class="chat" maxlength="250" aria-label="Type here to chat." /> 
      <input type="button" class="chat_submit btn btn-primary" value="Chat" />
    </div>
  </div>
</div>

<!-- Template for game lobbies in the game list. -->
<div class="hide">
	<div id="gamelist_lobby_template" class="gamelist_lobby" tabindex="0">
	<div class="gamelist_lobby_left">
	    	<h4>
			<span class="gamelist_lobby_host">host</span>'s Game
			(<span class="gamelist_lobby_player_count"></span>/<span class="gamelist_lobby_max_players"></span>,
			<span class="gamelist_lobby_spectator_count"></span>/<span class="gamelist_lobby_max_spectators"></span>)
			<span class="gamelist_lobby_status">status</span>
		</h4>
		<div>
		<strong>Players:</strong>
		<span class="gamelist_lobby_players">host, player1, player2</span>
		</div>
		<div>
		<strong>Spectators:</strong>
		<span class="gamelist_lobby_spectators">spectator1</span>
		</div>
		<div><strong>Goal:</strong> <span class="gamelist_lobby_goal"></span></div>
		<div>
		<strong>Cards:</strong> <span class="gamelist_lobby_cardset"></span>
		</div>
		<div class="hide">Game <span class="gamelist_lobby_id">###</span></div>
	  </div>
	  <div class="gamelist_lobby_right">
	    <input type="button" class="gamelist_lobby_join btn btn-primary" value="Join" />
	    <input type="button" class="gamelist_lobby_spectate btn btn-success" value="Spectate" />
	  </div>
	</div>
</div>

<!-- Template for face-up black cards. -->
<div class="hide">
	<div id="black_up_template" class="card blackcard">
	  <span class="card_text">The quick brown fox jumped over the lazy dog.</span>
	  <div class="logo">
	    <div class="logo_1 logo_element">
	    </div>
	    <div class="logo_2 logo_element">
	    </div>
	    <div class="logo_3 logo_element watermark_container">
        <br/>
        <span class="watermark"></span>
	    </div>
	    <div class="logo_text">Pretend You're Xyzzy</div>
	  </div>
    <div class="card_metadata">
      <div class="draw hide">DRAW <div class="card_number"></div></div>
      <div class="pick hide">PICK <div class="card_number"></div></div>
    </div>
	</div>
</div>

<!-- Template for face-down black cards. -->
<div class="hide">
	<div id="black_down_template" class="card blackcard">
	</div>
</div>

<!-- Template for face-up white cards. -->
<div class="hide">
	<div id="white_up_template" class="card whitecard">
	  <span class="card_text" role="button" tabindex="0">The quick brown fox jumped over the lazy dog.</span>
	  <div class="logo">
	    <div class="logo_1 logo_element">
	    </div>
	    <div class="logo_2 logo_element">
	    </div>
	    <div class="logo_3 logo_element watermark_container">
        <br/>
        <span class="watermark"></span>
	    </div>
	    <div class="logo_text">Pretend You're Xyzzy</div>
	  </div>
	</div>
</div>

<!-- Template for face-down white cards. -->
<div class="hide">
	<div id="white_down_template" class="card whitecard">
	</div>
</div>

<!-- Template for game lobbies. We have a holder here for designing only. -->
<div style="width: 1000px; height: 506px; border: 1px solid black; position: relative;"
    class="hide">
  <div id="game_template" class="game">
    <div class="game_top">
      <input type="button" class="game_show_last_round game_menu_bar btn btn-info" value="Show Last Round"
          disabled="disabled" />
      <input type="button" class="game_show_options game_menu_bar btn btn-primary" value="Hide Game Options" />
      <label class="game_menu_bar checkbox"><input type="checkbox" class="game_animate_cards" checked="checked" /><span> Animate Cards</span></label>
      <div class="game_message" role="status">
        Waiting for server...
      </div>
    </div>
    <div style="width:100%; height:472px;">
      <div style="width:100%; height:100%;">
        <div class="game_left_side">
          <div class="game_black_card_wrapper">
            <span tabindex="0">The black card for
                <span class="game_black_card_round_indicator">this round is</span>:
            </span>
            <div class="game_black_card" tabindex="0">
            </div>
          </div>
          <input type="button" class="confirm_card btn btn-primary" value="Confirm Selection" />
        </div>
        <div class="game_options">
        </div>
        <div class="game_right_side hide">
          <div class="game_right_side_box game_white_card_wrapper">
            <span tabindex="0">The white cards played this round are:</span>
            <div class="game_white_cards game_right_side_cards">
            </div>
          </div>
          <div class="game_right_side_box game_last_round hide">
            The previous round was won by <span class="game_last_round_winner"></span>.
            <div class="game_last_round_cards game_right_side_cards">
            </div>
          </div>
        </div>
      </div>
      <div class="game_hand">
        <div class="game_hand_filter hide">
          <span class="game_hand_filter_text"></span>
        </div>
        <span class="your_hand" tabindex="0">Your Hand</span>
        <div class="game_hand_cards">
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Template for scoreboard container. Holder for design. -->
<!--<div style="height: 215px; border: 1px solid black;" class="hide">-->
<div style="container" class="hide">
	<div id="scoreboard_template" class="scoreboard">
    <div class="game_message" tabindex="0">Scoreboard</div>
	</div>
</div>

<!-- Template for scoreboard score card. Holder for design. -->
<div class="scoreboard hide" style="height: 215px;">
	<div id="scorecard_template" class="scorecard" tabindex="0">
	  <span class="scorecard_player">PlayerName</span>
	  <div class="clear"></div>
	  <span class="scorecard_points"><span class="scorecard_score">0</span> <span class="scorecard_point_title">Awesome Point<span class="scorecard_s">s</span></span></span>
	  <span class="scorecard_status">Status</span>
	</div>
</div>

<!-- Template for round card set binder. -->
<div class="hide">
	<div id="game_white_cards_binder_template" class="game_white_cards_binder hide">
	</div>
</div>

<!-- Previous round display. -->
<div class="hide">
  <div id="previous_round_template" class="previous_round">
    <input type="button" class="previous_round_close" value="Close" />
    Round winner: <span class="previous_round_winner"></span>
    <div class="previous_round_cards"></div>
  </div>
</div>

<!-- Template for game options. -->
<div class="hide">
  <div class="game_options well" id="game_options_template">
    <span class="options_host_only">Only the game host can change options.</span>
    <br/><br/>
    <fieldset>
      <legend class="l6g">Game options:</legend>
      <label id="score_limit_template_label" for="score_limit_template">Score limit:</label>
      <select id="score_limit_template" class="score_limit">
        <%
          for (int i = GameOptions.MIN_SCORE_LIMIT; i <= GameOptions.MAX_SCORE_LIMIT; i++) {
        %>
          <option <%= i == GameOptions.DEFAULT_SCORE_LIMIT ? "selected='selected' " : "" %>value="<%= i %>"><%= i %></option>
        <% } %>
      </select>
      <br/>
      <label id="player_limit_template_label" for="player_limit_template">Player limit:</label>
      <select id="player_limit_template" class="player_limit"
          aria-label="Player limit. Having more than 10 players may cause issues both for screen readers and traditional browsers.">
        <%
          for (int i = GameOptions.MIN_PLAYER_LIMIT; i <= GameOptions.MAX_PLAYER_LIMIT; i++) {
        %>
          <option <%= i == GameOptions.DEFAULT_PLAYER_LIMIT ? "selected='selected' " : "" %>value="<%= i %>"><%= i %></option>
        <% } %>
      </select>
      Having more than 10 players may get cramped!
      <br/>
      <label id="spectator_limit_template_label" for="spectator_limit_template">Spectator limit:</label>
      <select id="spectator_limit_template" class="spectator_limit"
          aria-label="Spectator limit.">
        <%
          for (int i = GameOptions.MIN_SPECTATOR_LIMIT; i <= GameOptions.MAX_SPECTATOR_LIMIT; i++) {
        %>
          <option <%= i == GameOptions.DEFAULT_SPECTATOR_LIMIT ? "selected='selected' " : "" %>value="<%= i %>"><%= i %></option>
        <% } %>
      </select>
      Spectators can watch and chat, but not actually play. Not even as Czar.
      <br/>
      <input type="checkbox" checked="checked" id="use_timer_template" class="use_timer"
          title="Players will be skipped if they have not played within a reasonable amount of time."
          aria-label="Use idle timer. Players will be skipped if they have not played within a reasonable amount of time."/>
      <label id="use_timer_template_label" for="use_timer_template"
          title="Players will be skipped if they have not played within a reasonable amount of time.">
          Use idle timer.
      </label>
      <br/>
  <fieldset class="card_sets">
        <legend class="l6g">Card Sets:</legend>
       <span class="base_card_sets carddisplayer"></span>
<span class="extra_card_sets carddisplayer"></span>
      </fieldset>
      <br/>
      <label id="blanks_limit_label" title="Blank cards allow a player to type in their own answer.">
        Also include <select id="blanks_limit_template" class="blanks_limit">
        <%
          for (int i = GameOptions.MIN_BLANK_CARD_LIMIT; i <= GameOptions.MAX_BLANK_CARD_LIMIT; i++) {
        %>
          <option <%= i == GameOptions.DEFAULT_BLANK_CARD_LIMIT ? "selected='selected' " : "" %>value="<%= i %>"><%= i %></option>
        <% } %>
        </select> blank white cards.
      </label>
      <br/>
      <label id="game_password_template_label" for="game_password_template">Game password:</label>
      <input type="text" id="game_password_template" class="game_password span2"
          aria-label="Game password. You must tab outside of the box to apply the password."/>
      <input type="password" id="game_fake_password_template" class="game_fake_password hide" />
      You must click outside the box to apply the password.
      <input type="checkbox" id="game_hide_password_template" class="game_hide_password" />
      <label id="game_hide_password_template_label" for="game_hide_password_template"
          aria-label="Hide password from your screen."
          title="Hides the password from your screen, so people watching your stream can't see it.">
        Hide password.
      </label>
    </fieldset>
  </div>
</div>
<div style="position:absolute; left:-99999px" role="alert" id="aria-notifications"></div>
<script type="text/javascript" src="js/nightui-btst.js"></script>
<!--
<script type="text/javascript">
$( ".game_right_side" ).hover(function() {
	$( this ).style.zIndex = "1000";
	$( ".game_hand_cards" ).style.zIndex = "0";
	}

$( ".game_hand_cards" ).hover(function() {
	$( this ).style.zIndex = "1000";
	$( ".game_right_side" ).style.zIndex = "0";
	}
</script>
-->
</body>
</html>