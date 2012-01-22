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
  $(this.element_).removeClass("template");
};

/**
 * @return {HTMLDivElement} This object's element.
 */
cah.Game.prototype.getElement = function() {
  return this.element_;
};

$(document).ready(function() {
  var game = new cah.Game(0);
  $("#main").append(game.getElement());

  var cards = Array();
  for ( var i = 0; i < 10; i++) {
    var card = new cah.card.BlackCard(true);
    card.setText("This is card " + i);
    cards.push(card);
    jQuery(".game_hand_cards", game.getElement()).append(card.getElement());

    var data = {
      card : card.getElement()
    };
    var options = {
      duration : 500,
      queue : false
    };
    $(card.getElement()).mouseenter(data, function(e) {
      $(e.data.card).animate({
        zoom : 2
      }, options);
    }).mouseleave(data, function(e) {
      $(e.data.card).animate({
        zoom : 1
      }, options);
    });
  }

});
