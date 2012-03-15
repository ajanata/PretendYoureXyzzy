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
The main game page. This is almost entirely static HTML, other than ensuring that a session is
created for the user now.

@author Andy Janata (ajanata@socialgamer.net)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
// Ensure a session exists for the user.
@SuppressWarnings("unused")
HttpSession hSession = request.getSession(true);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Pretend You're Xyzzy</title>
<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/QTransform.js"></script>
<script type="text/javascript" src="js/cah.js"></script>
<script type="text/javascript" src="js/cah.config.js"></script>
<%-- cah must be first, ajax must be before app. app probably has to be last. --%>
<%-- TODO make this be dynamic with looking at the filesystem and using jquery --%>
<%-- except that is nontrivial thanks to dependency ordering -_- --%>
<script type="text/javascript" src="js/cah.constants.js"></script>
<script type="text/javascript" src="js/cah.log.js"></script>
<script type="text/javascript" src="js/cah.gamelist.js"></script>
<script type="text/javascript" src="js/cah.card.js"></script>
<script type="text/javascript" src="js/cah.game.js"></script>
<script type="text/javascript" src="js/cah.longpoll.js"></script>
<script type="text/javascript" src="js/cah.longpoll.handlers.js"></script>
<script type="text/javascript" src="js/cah.ajax.js"></script>
<script type="text/javascript" src="js/cah.ajax.builder.js"></script>
<script type="text/javascript" src="js/cah.ajax.handlers.js"></script>
<script type="text/javascript" src="js/cah.app.js"></script>
<link rel="stylesheet" type="text/css" href="cah.css" media="screen" />
</head>
<body>

<%--
<div id="browser" class="hide">
  <div id="browser_inner">
	  <p>Pretend You're Xyzzy is known to have graphical glitches in
	  <span id="browser_name">$BROWSER_NAME</span>. The game should work,
	  but it looks much better in <a href="http://google.com/chrome/">Google Chrome.</a></p>
	  <p>We will not bug you about this again after you dismiss this dialog.</p>
	  <input type="button" id="browser_ok" value="Okay, I Understand" />
  </div>
</div>
--%>

<div id="nickbox">
  Having trouble logging in? Clear your cache.
  Nickname: <input type="text" id="nickname" value="" maxlength="30" />
  <input type="button" id="nicknameconfirm" value="Set" />
  <span id="nickbox_error" class="error"></span>
</div>

<div id="canvas" class="hide">
  <div id="menubar">
    <div id="menubar_left">
      <input type="button" id="refresh_games" class="hide" value="Refresh Games" />
      <input type="button" id="create_game" class="hide" value="Create Game" />
      <input type="button" id="leave_game" class="hide" value="Leave Game" />
      <input type="button" id="start_game" class="hide" value="Start Game" />
    </div>
    <div id="menubar_right">
      <input type="button" id="logout" value="Log out" />
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
  <div id="chat_area">
    <div id="log"></div>
    <input type="text" id="chat" maxlength="200" />
    <input type="button" id="chat_submit" value="Chat" />
  </div>
</div>

<!-- Template for game lobbies in the game list. -->
<div class="hide">
	<div id="gamelist_lobby_template" class="gamelist_lobby">
	  <div class="gamelist_lobby_left">
	    Game <span class="gamelist_lobby_id">###</span>
	    <span class="gamelist_lobby_status">status</span>
	    <br/>
	    Host: <span class="gamelist_lobby_host">host</span>
	    <br/>
	    Players: <span class="gamelist_lobby_players">host, player1, player2</span>
	  </div>
	  <div class="gamelist_lobby_right">
	    <input type="button" class="gamelist_lobby_join" value="Join" />
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
	    <div class="logo_3 logo_element">
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
	  <span class="card_text">The quick brown fox jumped over the lazy dog.</span>
	  <div class="logo">
	    <div class="logo_1 logo_element">
	    </div>
	    <div class="logo_2 logo_element">
	    </div>
	    <div class="logo_3 logo_element">
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
      <input type="button" class="game_show_last_round" value="Show Last Round"
          disabled="disabled" />
      <div class="game_message">
        Waiting for server...
      </div>
    </div>
    <div style="width:100%; height:100%;">
      <div style="width:100%; height:100%;">
        <div class="game_left_side">
          <div class="game_black_card_wrapper">
            The black card for <span class="game_black_card_round_indicator">this round is</span>:
            <div class="game_black_card">
            </div>
          </div>
          <input type="button" class="confirm_card" value="Confirm Selection" />
        </div>
        <div class="game_right_side">
          <div class="game_right_side_box game_white_card_wrapper">
            The white cards played this round are:
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
        <span class="header">Your Hand</span>
        <div class="game_hand_cards">
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Template for scoreboard container. Holder for design. -->
<div style="height: 215px; border: 1px solid black;" class="hide">
	<div id="scoreboard_template" class="scoreboard">
	</div>
</div>

<!-- Template for scoreboard score card. Holder for design. -->
<div class="scoreboard hide" style="height: 215px;">
	<div id="scorecard_template" class="scorecard">
	  <span class="scorecard_player">PlayerName</span>
	  <div class="clear"></div>
	  <span class="scorecard_score">0</span> Awesome Point<span class="scorecard_s">s</span>
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

</body>
</html>
