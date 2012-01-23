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
   * @type {Array[cah.GameListLobby]}
   * @private
   */
  this.games_ = new Array();

  $("#create_game").click(cah.bind(this, this.createGameClick_));
  $("#refresh_games").click(cah.bind(this, this.refreshGamesClick_));
};

$(document).ready(function() {
  cah.GameList.instance = new cah.GameList();
});

cah.GameList.prototype.show = function() {
  $(this.element_).show();
  $("#create_game").show();
  $("#refresh_games").show();

  // $(this.element_).removeClass("hide");
  // $("#create_game").removeClass("hide");
  // $("#refresh_games").removeClass("hide");
};

cah.GameList.prototype.hide = function() {
  $(this.element_).hide();
  $("#create_game").hide();
  $("#refresh_games").hide();

  // $(this.element_).addClass("hide");
  // $("#create_game").addClass("hide");
  // $("#refresh_games").addClass("hide");
};

cah.GameList.prototype.update = function() {
  // TODO display a loading indicator of some sort
  cah.Ajax.build(cah.$.AjaxOperation.GAME_LIST).run();
};

/**
 * Update the list of games.
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

  this.element_.id = "gamelist_lobby_" + this.id_;
  $(parentElem).append(this.element_);
  $(this.element_).removeClass("hide");
  jQuery(".gamelist_lobby_id", this.element_).text(this.id_);
  jQuery(".gamelist_lobby_host", this.element_).text(data[cah.$.GameInfo.HOST]);
  jQuery(".gamelist_lobby_players", this.element_).text(data[cah.$.GameInfo.PLAYERS].join(", "));
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
  jQuery(".gamelist_lobby_status", this.element_).text(statusMessage).addClass(
      "gamelist_lobby_status_" + statusClass);
  if (statusClass == "unjoinable") {
    jQuery(".gamelist_lobby_join", this.element_).attr("disabled", "disabled");
  } else {
    jQuery(".gamelist_lobby_join", this.element_).click(cah.bind(this, this.joinClick));
  }
};

cah.GameListLobby.prototype.joinClick = function(e) {
  cah.Ajax.build(cah.$.AjaxOperation.JOIN_GAME).withGameId(this.id_).run();
};

cah.GameListLobby.prototype.dispose = function() {
  this.parentElem_.removeChild(this.element_);
  jQuery(".gamelist_lobby_join", this.element_).unbind();
};
