/*
 * Copyright (c) 2012, Andy Janata
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * 
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 *   and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 *   conditions and the following disclaimer in the documentation and/or other materials provided
 *   with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * Display the list of games on the server, and enable the player to join a game. This is a
 * singleton.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 * @constructor
 */
cah.GameList = function() {
  /**
   * The game list DOM element.
   * 
   * @type {HTMLDivElement}
   * @private
   */
  this.element_ = $("#game_list")[0];

  /**
   * Array of all game lobby objects.
   * 
   * @type {Array[cah.GameListLobby]}
   * @private
   */
  this.games_ = new Array();

  $("#create_game").click(cah.bind(this, this.createGameClick_));
  $("#refresh_games").click(cah.bind(this, this.refreshGamesClick_));
};

$(document).ready(function() {
  /**
   * The singleton instance of GameList.
   * 
   * @type {cah.GameList}
   */
  cah.GameList.instance = new cah.GameList();
});

/**
 * Show the game list.
 */
cah.GameList.prototype.show = function() {
  $(this.element_).show();
  $("#create_game").show();
  $("#refresh_games").show();
};

/**
 * Hide the game list.
 */
cah.GameList.prototype.hide = function() {
  $(this.element_).hide();
  $("#create_game").hide();
  $("#refresh_games").hide();
};

/**
 * Query the server to update the game list.
 */
cah.GameList.prototype.update = function() {
  // TODO display a loading indicator of some sort
  cah.Ajax.build(cah.$.AjaxOperation.GAME_LIST).run();
};

/**
 * Update the list of games with fresh data from the server.
 * 
 * @param {Object}
 *          gameData The game data returned by the server.
 */
cah.GameList.prototype.processUpdate = function(gameData) {
  for ( var key in this.games_) {
    this.games_[key].dispose();
  }
  this.games_ = new Array();

  for ( var key in gameData[cah.$.AjaxResponse.GAMES]) {
    var game = gameData[cah.$.AjaxResponse.GAMES][key];
    var lobby = new cah.GameListLobby(this.element_, game);
    this.games_.push(lobby);
  }

  if (gameData[cah.$.AjaxResponse.GAMES].length < gameData[cah.$.AjaxResponse.MAX_GAMES]) {
    $("#create_game").removeAttr("disabled");
  } else {
    $("#create_game").attr("disabled", "disabled");
  }
};

/**
 * Event handler for the clicking the Create Game button.
 * 
 * @private
 */
cah.GameList.prototype.createGameClick_ = function() {
  cah.Ajax.build(cah.$.AjaxOperation.CREATE_GAME).run();
};

/**
 * Event handler for clicking the Refresh Games button.
 * 
 * @private
 */
cah.GameList.prototype.refreshGamesClick_ = function() {
  this.update();
};

// ///////////////////////////////////////////////

/**
 * A single entry in the game list.
 * 
 * @param {HTMLElement}
 *          parentElem Element under which to display this.
 * @param {Object}
 *          data This game's data.
 * @constructor
 */
cah.GameListLobby = function(parentElem, data) {
  /**
   * The game id represented by this lobby.
   * 
   * @type {number}
   * @private
   */
  this.id_ = data[cah.$.GameInfo.ID];

  /**
   * The element we live under.
   * 
   * @type {HTMLElement}
   * @private
   */
  this.parentElem_ = parentElem;

  /**
   * This game lobby's dom element.
   * 
   * @type {HTMLDivElement}
   * @private
   */
  this.element_ = $("#gamelist_lobby_template").clone()[0];

  /**
   * This game's data.
   * 
   * @type {object}
   * @private
   */
  this.data_ = data;

  this.element_.id = "gamelist_lobby_" + this.id_;
  $(parentElem).append(this.element_);
  $(this.element_).removeClass("hide");
  $(".gamelist_lobby_id", this.element_).text(this.id_);
  $(".gamelist_lobby_host", this.element_).text(data[cah.$.GameInfo.HOST]);
  $(".gamelist_lobby_players", this.element_).text(data[cah.$.GameInfo.PLAYERS].join(", "));
  var statusMessage = cah.$.GameState_msg[data[cah.$.GameInfo.STATE]];
  $(".gamelist_lobby_status", this.element_).text(statusMessage);
  $(".gamelist_lobby_join", this.element_).click(cah.bind(this, this.joinClick));
  $(".gamelist_lobby_player_count", this.element_).text(data[cah.$.GameInfo.PLAYERS].length);
  $(".gamelist_lobby_max_players", this.element_).text(data[cah.$.GameInfo.PLAYER_LIMIT]);
  $(".gamelist_lobby_goal", this.element_).text(data[cah.$.GameInfo.SCORE_LIMIT]);
  // TODO make this better when we have more card sets
  var cardset = "All";
  if (data[cah.$.GameInfo.CARD_SET] == 1) {
    cardset = "First Edition";
  } else if (data[cah.$.GameInfo.CARD_SET] == 2) {
    cardset = "Second Edition";
  }
  $(".gamelist_lobby_cardset", this.element_).text(cardset);

  if (data[cah.$.GameInfo.HAS_PASSWORD]) {
    $(".gamelist_lobby_join", this.element_).val("Join\n(Passworded)");
  }
};

/**
 * Event handler for clicking the Join button in a game lobby.
 */
cah.GameListLobby.prototype.joinClick = function() {
  var password = "";
  if (this.data_[cah.$.GameInfo.HAS_PASSWORD]) {
    password = prompt("Enter the game's password.");
    if (password == null) {
      password = "";
    }
  }
  cah.Ajax.build(cah.$.AjaxOperation.JOIN_GAME).withGameId(this.id_).withPassword(password).run();
};

/**
 * Remove the game lobby from the document and free up resources.
 */
cah.GameListLobby.prototype.dispose = function() {
  this.parentElem_.removeChild(this.element_);
  $(".gamelist_lobby_join", this.element_).unbind();
};
