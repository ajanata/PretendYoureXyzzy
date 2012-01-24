/**
 * Game interface.
 * 
 * @author ajanata
 */

/**
 * Class to manage the game interface.
 * 
 * @param {number}
 *          id The game id.
 * 
 * @constructor
 */
cah.Game = function(id) {
  /**
   * The game id.
   * 
   * @type {number}
   * @private
   */
  this.id_ = id;

  /**
   * The element for this game lobby.
   * 
   * @type {HTMLDivElement}
   * @private
   */
  this.element_ = $("#game_template").clone()[0];
  this.element_.id = "game_" + id;
  $(this.element_).removeClass("hide");

  /**
   * The element for the scoreboard for this game.
   * 
   * @type {HTMLDivElement}
   * @private
   */
  this.scoreboardElement_ = $("#scoreboard_template").clone()[0];
  this.scoreboardElement_.id = "scoreboard_" + id;
  $(this.scoreboardElement_).removeClass("hide");

  /**
   * User->value mapping of scorecards in the scoreboard.
   * 
   * @type {Object}
   * @private
   */
  this.scoreCards_ = {};

  /**
   * The cards in the player's hand.
   * 
   * @type {Array}
   * @private
   */
  this.hand_ = Array();

  $("#leave_game").click(cah.bind(this, this.leaveGameClick_));
  $("#start_game").click(cah.bind(this, this.startGameClick_));
};

/**
 * Load game data from the server and display the game lobby.
 * 
 * @param {number}
 *          gameId The game id.
 */
cah.Game.joinGame = function(gameId) {
  cah.Ajax.build(cah.$.AjaxOperation.GET_GAME_INFO).withGameId(gameId).run();
  cah.GameList.instance.hide();
  var game = new cah.Game(gameId);
  cah.currentGames[gameId] = game;
  game.insertIntoDocument();
};

/**
 * @return {HTMLDivElement} This object's element.
 */
cah.Game.prototype.getElement = function() {
  return this.element_;
};

/**
 * Add multiple cards to the player's hand.
 * 
 * @param {Array}
 *          cards The array of card objects sent from the server.
 */
cah.Game.prototype.dealtCards = function(cards) {
  for ( var index in cards) {
    var thisCard = cards[index];
    var card = new cah.card.WhiteCard(true, thisCard[cah.$.WhiteCardData.ID]);
    card.setText(thisCard[cah.$.WhiteCardData.TEXT]);
    this.dealtCard(card);
  }
};

/**
 * Add a card to the player's hand.
 * 
 * @param {cah.card.WhiteCard}
 *          card Card to add to hand.
 */
cah.Game.prototype.dealtCard = function(card) {
  this.hand_.push(card);
  var element = card.getElement();
  jQuery(".game_hand_cards", this.element_).append(element);
  var data = {
    card : element,
  };
  var options = {
    duration : 200,
    queue : false,
  };
  $(element).mouseenter(data, function(e) {
    $(e.data.card).animate({
      zoom : .7
    }, options);
  }).mouseleave(data, function(e) {
    $(e.data.card).animate({
      zoom : .35
    }, options);
  });
  $(element).css("zoom", ".35");
};

cah.Game.prototype.insertIntoDocument = function() {
  $("#main_holder").empty().append(this.element_);
  $("#info_area").empty().append(this.scoreboardElement_);
  $("#leave_game").show();
  // TODO display a loading animation
};

/**
 * Update game status display.
 * 
 * @param {Object}
 *          data Game data returned from server.
 */
cah.Game.prototype.updateGameStatus = function(data) {
  if (data[cah.$.AjaxResponse.GAME_INFO][cah.$.GameInfo.HOST] == cah.nickname
      && data[cah.$.AjaxResponse.GAME_INFO][cah.$.GameInfo.STATE] == cah.$.GameState.LOBBY) {
    $("#start_game").show();
  } else {
    $("#start_game").hide();
  }

  var playerInfos = data[cah.$.AjaxResponse.PLAYER_INFO];
  for ( var index in playerInfos) {
    var thisInfo = playerInfos[index];
    var playerName = thisInfo[cah.$.GamePlayerInfo.NAME];
    var panel = this.scoreCards_[playerName];
    if (!panel) {
      // new score panel
      panel = new cah.GameScorePanel(playerName);
      $(this.scoreboardElement_).append(panel.getElement());
      this.scoreCards_[playerName] = panel;
      // TODO remove panels for players that have left the game? or just on the event?
    }
    panel.update(thisInfo[cah.$.GamePlayerInfo.SCORE], thisInfo[cah.$.GamePlayerInfo.STATUS]);
  }
};

/**
 * Event handler for leave game button.
 * 
 * @private
 */
cah.Game.prototype.leaveGameClick_ = function() {
  // TODO make sure everything cleans up right, I got an error when I tried to start a different
  // game after leaving one
  cah.Ajax.build(cah.$.AjaxOperation.LEAVE_GAME).withGameId(this.id_).run();
};

/**
 * Event handler for start game button.
 * 
 * @private
 */
cah.Game.prototype.startGameClick_ = function() {
  cah.Ajax.build(cah.$.AjaxOperation.START_GAME).withGameId(this.id_).run();
};

/**
 * Free resources used by this game and remove from the document.
 */
cah.Game.prototype.dispose = function() {
  $(this.element_).remove();
  $(this.scoreboardElement_).remove();
  $("#leave_game").unbind().hide();
  $("#start_game").unbind().hide();
};

/**
 * A player has joined the game.
 * 
 * @param {String}
 *          player Player that joined.
 */
cah.Game.prototype.playerJoin = function(player) {
  if (player != cah.nickname) {
    cah.log.status(player + " has joined the game.");
    this.refreshGameStatus();
  } else {
    cah.log.status("You have joined the game.");
  }
};

/**
 * A player has left the game.
 * 
 * @param {String}
 *          player Player that left.
 */
cah.Game.prototype.playerLeave = function(player) {
  if (player != cah.nickname) {
    cah.log.status(player + " has left the game.");
    this.refreshGameStatus();
  } else {
    cah.log.status("You have left the game.");
  }
  var scorecard = this.scoreCards_[player];
  if (scorecard) {
    $(scorecard.getElement()).remove();
  }
  delete this.scoreCards_[player];
};

/**
 * Refresh game scoreboard, etc.
 */
cah.Game.prototype.refreshGameStatus = function() {
  cah.Ajax.build(cah.$.AjaxOperation.GET_GAME_INFO).withGameId(this.id_).run();
};

// /**
// * Remove a card from the hand.
// *
// * @param {number|cah.card.WhiteCard}
// * card If number, index of card to remove. If cah.card.WhiteCard, card instance to remove.
// */
// cah.Game.prototype.removeCard = function(card) {
//
// };

// ///////////////////////////////////////////////

/**
 * Create a scoreboard panel for a player.
 * 
 * @param {String}
 *          player Player name.
 * @constructor
 */
cah.GameScorePanel = function(player) {
  /**
   * Player name.
   * 
   * @type {String}
   * @private
   */
  this.player_ = player;

  /**
   * @type {HTMLDivElement}
   * @private
   */
  this.element_ = $("#scorecard_template").clone()[0];
  $(this.element_).removeClass("hide");

  /**
   * The score on this scorecard.
   * 
   * @type {number}
   * @private
   */
  this.score_ = 0;

  /**
   * The status of the player for this scorecard.
   * 
   * @type {cah.$.GamePlayerStatus}
   * @private
   */
  this.status_ = cah.$.GamePlayerStatus.IDLE;

  jQuery(".scorecard_player", this.element_).text(player);
  this.update(this.score_, this.status_);
};

cah.GameScorePanel.prototype.getElement = function() {
  return this.element_;
};

/**
 * Update the score panel.
 * 
 * TODO add some color for different statuses
 * 
 * @param {number}
 *          score The player's score
 * @param {cah.$.GamePlayerStatus}
 *          status The player's status.
 */
cah.GameScorePanel.prototype.update = function(score, status) {
  this.score_ = score;
  this.status_ = status;
  jQuery(".scorecard_score", this.element_).text(score);
  jQuery(".scorecard_status", this.element_).text(cah.$.GamePlayerStatus_msg[status]);
};

$(document).ready(function() {
  var game = new cah.Game(0);
  $("#main_holder").append(game.getElement());

  for ( var i = 0; i < 10; i++) {
    var card = new cah.card.WhiteCard(true);
    card.setText("This is card " + i);
    game.dealtCard(card);
  }
});
