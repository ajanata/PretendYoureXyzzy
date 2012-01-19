/**
 * Display the list of games on the server.
 * 
 * @author ajanata
 */

/**
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
   * @type {Array}
   * @private
   */
  this.games_ = new Array();

  $("#create_game").click(cah.bind(this, this.createGameClick_));
  $("#refresh_games").click(cah.bind(this, this.refreshGamesClick_));
};

$(document).ready(function() {
  cah.GameList.instance = new cah.GameList();
});

/**
 * Update the list of games.
 * 
 * @param {Object}
 *          gameData The game data returned by the server.
 */
cah.GameList.prototype.update = function(gameData) {
  while (this.element_.hasChildNodes()) {
    this.element_.removeChild(this.element_.firstChild);
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
 * @private
 */
cah.GameList.prototype.createGameClick_ = function(e) {
  cah.Ajax.build(cah.$.AjaxOperation.CREATE_GAME).run();
};

/**
 * @private
 */
cah.GameList.prototype.refreshGamesClick_ = function(e) {
  this.refreshGames();
};

cah.GameList.prototype.refreshGames = function() {
  cah.Ajax.build(cah.$.AjaxOperation.GAME_LIST).run();
};

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
   * This game lobby's dom element.
   * 
   * @type {HTMLDivElement}
   * @private
   */
  this.element_ = $("#gamelist_lobby_template").clone()[0];

  this.element_.id = "gamelist_lobby_" + this.id_;
  parentElem.appendChild(this.element_);
  $("#gamelist_lobby_" + this.id_ + " .gamelist_lobby_id").text(this.id_);
  $("#gamelist_lobby_" + this.id_ + " .gamelist_lobby_host").text(data[cah.$.GameInfo.HOST]);
  $("#gamelist_lobby_" + this.id_ + " .gamelist_lobby_players").text(
      data[cah.$.GameInfo.PLAYERS].join(", "));
  var statusClass = "unjoinable";
  var statusMessage = cah.$.GameState_msg[data[cah.$.GameInfo.STATE]];
  switch (data[cah.$.GameInfo.STATE]) {
    case cah.$.GameState.LOBBY:
      statusClass = "joinable";
      break;
    case cah.$.GameState.DEALING:
      statusClass = "unjoinable";
      break;
  }
  $("#gamelist_lobby_" + this.id_ + " .gamelist_lobby_status").text(statusMessage).addClass(
      "gamelist_lobby_status_" + statusClass);
  if (statusClass == "unjoinable") {
    $("#gamelist_lobby_" + this.id_ + " .gamelist_lobby_join").attr("disabled", "disabled");
  } else {
    $("#gamelist_lobby_" + this.id_ + " .gamelist_lobby_join")
        .click(cah.bind(this, this.joinClick));
  }
};

cah.GameListLobby.prototype.joinClick = function(e) {
  cah.Ajax.build(cah.$.AjaxOperation.JOIN_GAME).withGameId(this.id_).run();
};
