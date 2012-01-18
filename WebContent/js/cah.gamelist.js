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

  var foo = new cah.GameListLobby(0).getElement();

  for ( var i = 0; i < 50; i++) {
    this.element_.appendChild(new cah.GameListLobby(i).getElement());
  }
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
  // TODO clear existing display
};

/**
 * A single entry in the game list.
 * 
 * @param {number}
 *          id This game's id.
 * @constructor
 */
cah.GameListLobby = function(id) {
  this.id_ = id;
  this.element_ = $("#gamelist_lobby_template").clone()[0];
  this.element_.id = "gamelist_lobby_" + id;
};

cah.GameListLobby.prototype.getElement = function() {
  return this.element_;
};
