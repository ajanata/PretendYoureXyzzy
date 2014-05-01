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
   * Map all game lobby objects, id -> game lobby.
   * 
   * @type {Object}
   * @private
   */
  this.games_ = {};

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
  if ($(this.element_).is(":visible") && cah.windowActive) {
    // TODO display a loading indicator of some sort
    cah.Ajax.build(cah.$.AjaxOperation.GAME_LIST).run();
    cah.missedGameListRefresh = false;
  } else {
    cah.missedGameListRefresh = true;
  }
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
  this.games_ = {};

  // Sort the games into two lists, passworded and non-passworded.
  var passworded = new Array();
  var notPassworded = new Array();
  for ( var key in gameData[cah.$.AjaxResponse.GAMES]) {
    var game = gameData[cah.$.AjaxResponse.GAMES][key];
    if (game[cah.$.GameInfo.HAS_PASSWORD]) {
      passworded.push(game);
    } else {
      notPassworded.push(game);
    }
  }

  var games = notPassworded.concat(passworded);

  var bannedSets = cah.Preferences.getBannedCardSetIds();
  var requiredSets = cah.Preferences.getRequiredCardSetIds();

  for ( var i = 0; i < games.length; i++) {
    var game = games[i];

    var hasBanned = false;
    $(bannedSets).each(function(index, value) {
      if (-1 !== $.inArray(value, game[cah.$.GameInfo.CARD_SETS])) {
        hasBanned = true;
        return false;
      }
    });

    var missingRequired = false;
    $(requiredSets).each(function(index, value) {
      if (-1 === $.inArray(value, game[cah.$.GameInfo.CARD_SETS])) {
        missingRequired = true;
        return false;
      }
    });

    if (hasBanned || missingRequired) {
      continue;
    }

    var lobby = new cah.GameListLobby(this.element_, game);
    this.games_[game[cah.$.GameInfo.ID]] = lobby;
  }

  if (gameData[cah.$.AjaxResponse.GAMES].length < gameData[cah.$.AjaxResponse.MAX_GAMES]) {
    $("#create_game").removeAttr("disabled");
  } else {
    $("#create_game").attr("disabled", "disabled");
  }
};

/**
 * Join the given game.
 * 
 * @param {Number}
 *          id The id of the game to join.
 */
cah.GameList.prototype.joinGame = function(id) {
  var game = this.games_[Number(id)];
  if (game) {
    game.join();
  } else {
    throw 'Game ' + id + ' does not exist.';
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
  
  var options = data[cah.$.GameInfo.GAME_OPTIONS];

  this.element_.id = "gamelist_lobby_" + this.id_;
  $(parentElem).append(this.element_);
  $(this.element_).removeClass("hide");
  $(".gamelist_lobby_id", this.element_).text(this.id_);
  $(".gamelist_lobby_host", this.element_).text(data[cah.$.GameInfo.HOST]);
  $(".gamelist_lobby_players", this.element_).text(data[cah.$.GameInfo.PLAYERS].join(", "));
  $(".gamelist_lobby_spectators", this.element_).text(data[cah.$.GameInfo.SPECTATORS].join(", "));
  var statusMessage = cah.$.GameState_msg[data[cah.$.GameInfo.STATE]];
  $(".gamelist_lobby_status", this.element_).text(statusMessage);
  $(".gamelist_lobby_join", this.element_).click(cah.bind(this, this.joinClick));
  $(".gamelist_lobby_spectate", this.element_).click(cah.bind(this, this.spectateClick));
  $(".gamelist_lobby_player_count", this.element_).text(data[cah.$.GameInfo.PLAYERS].length);
  $(".gamelist_lobby_max_players", this.element_).text(options[cah.$.GameOptionData.PLAYER_LIMIT]);
  $(".gamelist_lobby_spectator_count", this.element_).text(data[cah.$.GameInfo.SPECTATORS].length);
  $(".gamelist_lobby_max_spectators", this.element_).text(options[cah.$.GameOptionData.SPECTATOR_LIMIT]);
  $(".gamelist_lobby_goal", this.element_).text(options[cah.$.GameOptionData.SCORE_LIMIT]);
  var cardSets = options[cah.$.GameOptionData.CARD_SETS];
  var cardSetNames = [];
  cardSets.sort();
  for (var key in cardSets) {
    var cardSetId = cardSets[key];
    cardSetNames.push(cah.CardSet.list[cardSetId].getName());
  }
  $(".gamelist_lobby_cardset", this.element_).html(cardSetNames.join(', '));

  if (data[cah.$.GameInfo.HAS_PASSWORD]) {
    $(".gamelist_lobby_join", this.element_).val("Join\n(Passworded)");
  }

  $(this.element_).attr(
      "aria-label",
      data[cah.$.GameInfo.HOST] + "'s game, with " + data[cah.$.GameInfo.PLAYERS].length + " of "
          + options[cah.$.GameOptionData.PLAYER_LIMIT] + " players, and " + data[cah.$.GameInfo.SPECTATORS].length
          + " of " + options[cah.$.GameOptionData.SPECTATOR_LIMIT] + "spectators. " + statusMessage + ". Goal is "
          + options[cah.$.GameOptionData.SCORE_LIMIT] + " Awesome Points. Using " + cardSetNames.length
          + " card set" + (cardSetNames.length == 1 ? "" : "s") + ". "
          + (data[cah.$.GameInfo.HAS_PASSWORD] ? "Has" : "Does not have") + " a password.");
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
 * Join this game, by simulating a click of its join button.
 */
cah.GameListLobby.prototype.join = function() {
  $('.gamelist_lobby_join', this.element_).click();
};

/**
 * Event handler for clicking the View button in a game lobby.
 */
cah.GameListLobby.prototype.spectateClick = function() {
  var password = "";
  if (this.data_[cah.$.GameInfo.HAS_PASSWORD]) {
    password = prompt("Enter the game's password.");
    if (password == null) {
      password = "";
    }
  }
  cah.Ajax.build(cah.$.AjaxOperation.SPECTATE_GAME).withGameId(this.id_).withPassword(password)
      .run();
};

/**
 * Remove the game lobby from the document and free up resources.
 */
cah.GameListLobby.prototype.dispose = function() {
  this.parentElem_.removeChild(this.element_);
  $(".gamelist_lobby_join", this.element_).unbind();
  $(".gamelist_lobby_spectate", this.element_).unbind();
};
