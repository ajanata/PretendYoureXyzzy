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

  /**
   * Map of id to card object for round cards.
   * 
   * @type {Object}
   * @private
   */
  this.roundCards_ = {};

  /**
   * The game's state.
   * 
   * @type {cah.$.GameState}
   * @private
   */
  this.state_ = cah.$.GameState.LOBBY;

  /**
   * The black card on display.
   * 
   * @type {cah.card.BlackCard}
   * @private
   */
  this.blackCard_ = null;

  /**
   * Selected card from the player's hand.
   * 
   * @type {cah.card.WhiteCard}
   * @private;
   */
  this.handSelectedCard_ = null;

  /**
   * Selected card from the round's white cards.
   * 
   * @type {cah.card.WhiteCard}
   * @private;
   */
  this.roundSelectedCard_ = null;

  /**
   * Card the player played this round.
   * 
   * TODO make this an array when we support the multiple play blacks
   * 
   * @type {cah.card.WhiteCard}
   * @private
   */
  this.myPlayedCard_ = null;

  /**
   * The judge of the current round.
   * 
   * @type {String}
   * @private
   */
  this.judge_ = null;

  /**
   * Scale factor for hand cards when zoomed out.
   * 
   * @type {Number}
   * @private
   */
  this.handCardSmallScale_ = .35;

  /**
   * Scale factor for hand cards when zoomed in.
   * 
   * @type {Number}
   * @private
   */
  this.handCardLargeScale_ = .6;

  /**
   * Size for hand cards when zoomed out.
   * 
   * @type {Number}
   * @private
   */
  this.handCardSmallSize_ = 83;

  /**
   * Size for hand cards when zoomed in.
   * 
   * @type {Number}
   * @private
   */
  this.handCardLargeSize_ = 142;

  /**
   * Scale factor for round cards when zoomed out.
   * 
   * @type {Number}
   * @private
   */
  this.roundCardSmallScale_ = 1;

  /**
   * Scale factor for round cards when zoomed in.
   * 
   * @type {Number}
   * @private
   */
  this.roundCardLargeScale_ = 1;

  /**
   * Size for round cards when zoomed out.
   * 
   * @type {Number}
   * @private
   */
  this.roundCardSmallSize_ = 236;

  /**
   * Size for round cards when zoomed in.
   * 
   * @type {Number}
   * @private
   */
  this.roundCardLargeSize_ = 236;

  $("#leave_game").click(cah.bind(this, this.leaveGameClick_));
  $("#start_game").click(cah.bind(this, this.startGameClick_));

  $(".confirm_card", this.element_).click(cah.bind(this, this.confirmClick_));

  $(window).on("resize.game_" + this.id_, cah.bind(this, this.windowResize_));
};

/**
 * Load game data from the server and display the game lobby.
 * 
 * @param {number}
 *          gameId The game id.
 */
cah.Game.joinGame = function(gameId) {
  cah.Ajax.build(cah.$.AjaxOperation.GET_GAME_INFO).withGameId(gameId).run();
  cah.Ajax.build(cah.$.AjaxOperation.GET_CARDS).withGameId(gameId).run();
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
 * Set the black card on display.
 * 
 * @param {Object}
 *          card Black card data from server.
 */
cah.Game.prototype.setBlackCard = function(card) {
  this.blackCard_ = new cah.card.BlackCard(true, card[cah.$.BlackCardData.ID]);
  this.blackCard_.setText(card[cah.$.BlackCardData.TEXT]);

  $(".game_black_card", this.element_).empty().append(this.blackCard_.getElement());
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
 * TODO: in IE, for some reason, the logo is only on the leftmost card.
 * 
 * @param {cah.card.WhiteCard}
 *          card Card to add to hand.
 */
cah.Game.prototype.dealtCard = function(card) {
  this.hand_.push(card);
  var element = card.getElement();
  $(".game_hand_cards", this.element_).append(element);

  $(element).css("transform-origin", "0 0");

  var data = {
    card : card,
  };
  $(element).on("mouseenter.hand", data, cah.bind(this, this.handCardMouseEnter_)).on(
      "mouseleave.hand", data, cah.bind(this, this.handCardMouseLeave_)).on("click.hand", data,
      cah.bind(this, this.handCardClick_));

  this.resizeHandCards_();
};

/**
 * Remove a card from the hand.
 * 
 * @param {cah.card.WhiteCard}
 *          card Card to remove.
 */
cah.Game.prototype.removeCardFromHand = function(card) {
  var cardIndex = -1;
  for ( var index in this.hand_) {
    if (this.hand_[index] == card) {
      cardIndex = index;
      break;
    }
  }
  if (cardIndex != -1) {
    $(card.getElement()).css("width", "").css("height", "").css("transform-origin", "").css(
        "z-index", "").css("-moz-transform", "").css("-ms-transform", "").css("-webkit-transform",
        "").css("-o-transform", "").off(".hand");
    this.hand_.splice(cardIndex, 1);
  }

  $(card.getElement(), $("game_hand_cards", this.element_)).remove();
  this.resizeHandCards_();
};

/**
 * Set the round white cards.
 * 
 * @param {Array}
 *          cards Array of cah.card.WhiteCard to display.
 */
cah.Game.prototype.setRoundWhiteCards = function(cards) {
  for ( var index in cards) {
    var card;
    var id = cards[index][cah.$.WhiteCardData.ID];
    if (id >= 0) {
      card = new cah.card.WhiteCard(true, id);
      card.setText(cards[index][cah.$.WhiteCardData.TEXT]);
    } else {
      card = new cah.card.WhiteCard();
    }
    this.addRoundWhiteCard_(card);
  }
};

/**
 * Add a white card to the round white cards area.
 * 
 * @param {cah.card.WhiteCard}
 *          card Card to add to area.
 * @private
 */
cah.Game.prototype.addRoundWhiteCard_ = function(card) {
  var element = card.getElement();
  $(".game_white_cards", this.element_).append(element);
  $(element).css("transform-origin", "0 0");

  var data = {
    card : card,
  };
  $(element).on("mouseenter.round", data, cah.bind(this, this.roundCardMouseEnter_)).on(
      "mouseleave.round", data, cah.bind(this, this.roundCardMouseLeave_)).on("click.round", data,
      cah.bind(this, this.roundCardClick_));

  this.roundCards_[card.getServerId()] = card;

  this.resizeRoundCards_();
};

/**
 * Event handler for hand card mouse enter.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.handCardMouseEnter_ = function(e) {
  $(e.data.card.getElement()).css("z-index", "2").animate({
    scale : this.handCardLargeScale_,
    width : this.handCardLargeSize_,
  }, {
    duration : 200,
    queue : false,
  });
};

/**
 * Event handler for hand card mouse leave.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.handCardMouseLeave_ = function(e) {
  $(e.data.card.getElement()).animate({
    scale : this.handCardSmallScale_,
    "z-index" : 1,
    width : this.handCardSmallSize_,
  }, {
    duration : 200,
    queue : false,
  });
};

/**
 * Event handler for round card mouse enter.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.roundCardMouseEnter_ = function(e) {
  $(e.data.card.getElement()).css("z-index", "2").animate({
    scale : this.roundCardLargeScale_,
    width : this.roundCardLargeSize_,
  }, {
    duration : 200,
    queue : false,
  });
};

/**
 * Event handler for round card mouse leave.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.roundCardMouseLeave_ = function(e) {
  $(e.data.card.getElement()).animate({
    scale : this.roundCardSmallScale_,
    "z-index" : 1,
    width : this.roundCardSmallSize_,
  }, {
    duration : 200,
    queue : false,
  });
};

/**
 * Event handler for window resize.
 * 
 * @private
 */
cah.Game.prototype.windowResize_ = function() {
  this.resizeHandCards_();
  this.resizeRoundCards_();
};

/**
 * Resize cards in hand to fit window size and hand size.
 * 
 * @private
 */
cah.Game.prototype.resizeHandCards_ = function() {
  var elems = $(".game_hand_cards .card_holder", this.element_);
  var ct = elems.length;
  this.handCardSmallSize_ = ($(".game_hand_cards", this.element_).width() - 20) / (ct + 1);
  if (this.handCardSmallSize_ > 150) {
    this.handCardSmallSize_ = 150;
  }
  this.handCardLargeSize_ = this.handCardSmallSize_ * 1.8;
  this.handCardSmallScale_ = this.handCardSmallSize_ / 236;
  this.handCardLargeScale_ = this.handCardSmallScale_ * 1.8;
  elems.width(this.handCardSmallSize_).height(this.handCardSmallSize_).animate({
    scale : this.handCardSmallScale_,
  }, {
    duration : 0,
  });
};

/**
 * Resize cards in the round white cards are to fit window size and number of players.
 * 
 * TODO This will need some more consideration when there are multiple cards played per player.
 * 
 * @private
 */
cah.Game.prototype.resizeRoundCards_ = function() {
  var elems = $(".game_white_cards .card_holder", this.element_);
  var ct = elems.length;
  // 30 by experiment in chrome.
  $(".game_right_side", this.element_).width(
      $(window).width() - $(".game_left_side", this.element_).width() - 30);
  this.roundCardSmallSize_ = ($(".game_white_cards", this.element_).width() - 20 - $(
      ".game_left_side", this.element_).width())
      / ct;
  if (this.roundCardSmallSize_ > 236) {
    this.roundCardSmallSize_ = 236;
  }
  if (this.roundCardSmallSize_ < 118) {
    this.roundCardSmallSize_ = 118;
  }
  var maxScale = 236 / this.roundCardSmallSize_;
  var scale = maxScale < 1.8 ? maxScale : 1.8;
  this.roundCardLargeSize_ = this.roundCardSmallSize_ * scale;
  if (this.roundCardLargeSize_ > 236) {
    this.roundCardLargeSize_ = 236;
  }
  this.roundCardSmallScale_ = this.roundCardSmallSize_ / 236;
  this.roundCardLargeScale_ = this.roundCardSmallScale_ * scale;
  if (this.roundCardLargeScale_ > maxScale) {
    this.roundCardLargeScale_ = maxScale;
  }
  elems.width(this.roundCardSmallSize_).height(this.roundCardSmallSize_).animate({
    scale : this.roundCardSmallScale_,
  }, {
    duration : 0,
  });
};

cah.Game.prototype.insertIntoDocument = function() {
  $("#main_holder").empty().append(this.element_);
  $("#info_area").empty().append(this.scoreboardElement_);
  $("#leave_game").show();
  this.windowResize_();
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

  if (data[cah.$.AjaxResponse.GAME_INFO][cah.$.GameInfo.STATE] == cah.$.GameState.PLAYING) {
    $(".game_white_cards", this.element_).empty();
  }

  var playerInfos = data[cah.$.AjaxResponse.PLAYER_INFO];
  for ( var index in playerInfos) {
    this.updateUserStatus(playerInfos[index]);
  }
};

/**
 * Update a single player's info.
 * 
 * @param {Object}
 *          playerInfo The PlayerInfo from the server.
 */
cah.Game.prototype.updateUserStatus = function(playerInfo) {
  var playerName = playerInfo[cah.$.GamePlayerInfo.NAME];
  var playerStatus = playerInfo[cah.$.GamePlayerInfo.STATUS];
  var panel = this.scoreCards_[playerName];
  if (!panel) {
    // new score panel
    panel = new cah.GameScorePanel(playerName);
    $(this.scoreboardElement_).append(panel.getElement());
    this.scoreCards_[playerName] = panel;
  }
  var oldStatus = panel.getStatus();
  panel.update(playerInfo[cah.$.GamePlayerInfo.SCORE], playerStatus);

  if (playerName == cah.nickname) {
    $(".game_message", this.element_).text(cah.$.GamePlayerStatus_msg_2[playerStatus]);
    if (playerStatus == cah.$.GamePlayerStatus.PLAYING && this.handSelectedCard_ != null) {
      $(".confirm_card", this.element_).removeAttr("disabled");
    } else if (playerStatus == cah.$.GamePlayerStatus.JUDGING && this.roundSelectedCard_ != null) {
      $(".confirm_card", this.element_).removeAttr("disabled");
    } else {
      $(".confirm_card", this.element_).attr("disabled", "disabled");
    }
    if (playerStatus != cah.$.GamePlayerStatus.PLAYING) {
      if (this.handSelectedCard_ != null) {
        // we have a card selected, but we're changing state. this almost certainly is an
        // out-of-order reception of events. remove it from hand, we don't need to do anything else
        this.removeCardFromHand(this.handSelectedCard_);
      }
      this.handSelectedCard_ = null;
      $(".selected", $(".game_hand", this.element_)).removeClass("selected");
    }
    if (playerStatus == cah.$.GamePlayerStatus.HOST) {
      $("#start_game").show();
    }
  }

  if (playerStatus == cah.$.GamePlayerStatus.JUDGE
      || playerStatus == cah.$.GamePlayerStatus.JUDGING) {
    this.judge_ = playerName;
  }

  if (oldStatus == cah.$.GamePlayerStatus.PLAYING && playerStatus == cah.$.GamePlayerStatus.IDLE) {
    // this player played a card. display a face-down white card in the area, or nothing if it is
    // us. we put the card there when we get the acknowledgement from the server from playing.
    // also, don't put the card up if we're already into judging state -- we already displayed all
    // of the cards!
    if (playerName != cah.nickname && this.state_ == cah.$.GameState.PLAYING) {
      this.addRoundWhiteCard_(new cah.card.WhiteCard());
    }
  }
};

/**
 * Round has completed. Update display of round cards to show winner.
 * 
 * @param {Object}
 *          data Data from server.
 */
cah.Game.prototype.roundComplete = function(data) {
  var card = this.roundCards_[data[cah.$.LongPollResponse.WINNING_CARD]];
  $(".card", card.getElement()).addClass("selected");
  var scoreCard = this.scoreCards_[data[cah.$.LongPollResponse.ROUND_WINNER]];
  $(scoreCard.getElement()).addClass("selected");
  $(".confirm_card", this.element_).attr("disabled", "disabled");
  cah.log.status("The next round will begin in "
      + (data[cah.$.LongPollResponse.INTERMISSION] / 1000) + " seconds.");
};

/**
 * Notify the player that a deck has been reshuffled.
 * 
 * @param {String}
 *          deck Deck name which has been reshuffled.
 */
cah.Game.prototype.reshuffle = function(deck) {
  cah.log.status("The " + deck + " deck has been reshuffled.");
};

/**
 * Notify the player that the judge has left the game and cards are being returned to hands.
 */
cah.Game.prototype.judgeLeft = function() {
  cah.log
      .status("The judge has left the game. Cards played this round are being returned to hands.");
};

/**
 * Event handler for confirm selection button.
 * 
 * @private
 */
cah.Game.prototype.confirmClick_ = function() {
  if (this.judge_ == cah.nickname) {
    if (this.roundSelectedCard_ != null) {
      // TODO fix for multiple select
      cah.Ajax.build(cah.$.AjaxOperation.JUDGE_SELECT).withGameId(this.id_).withCardId(
          this.roundSelectedCard_.getServerId()).run();
    }
  } else {
    if (this.handSelectedCard_ != null) {
      cah.Ajax.build(cah.$.AjaxOperation.PLAY_CARD).withGameId(this.id_).withCardId(
          this.handSelectedCard_.getServerId()).run();
    }
  }
};

/**
 * Event handler for clicking on a card in the hand.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.handCardClick_ = function(e) {
  // judge can't select a card.
  if (this.judge_ == cah.nickname) {
    return;
  }
  // this player isn't in playing state
  var scorecard = this.scoreCards_[cah.nickname];
  if (scorecard && scorecard.getStatus() != cah.$.GamePlayerStatus.PLAYING) {
    return;
  }
  /** @type {cah.card.WhiteCard} */
  var card = e.data.card;

  // remove style from existing selected card
  if (this.handSelectedCard_) {
    $(".card", this.handSelectedCard_.getElement()).removeClass("selected");
  }

  // if the user clicked on the same card, deselect it.
  if (card == this.handSelectedCard_) {
    this.handSelectedCard_ = null;
    $(".confirm_card", this.element_).attr("disabled", "disabled");
  } else {
    this.handSelectedCard_ = card;
    $(".card", card.getElement()).addClass("selected");
    $(".confirm_card", this.element_).removeAttr("disabled");
  }
};

/**
 * Event handler for clicking on a card in the round.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.roundCardClick_ = function(e) {
  // this player isn't in judging state.
  var scorecard = this.scoreCards_[cah.nickname];
  if (scorecard && scorecard.getStatus() != cah.$.GamePlayerStatus.JUDGING) {
    return;
  }
  /** @type {cah.card.WhiteCard} */
  var card = e.data.card;

  // remove style from existing selected card
  if (this.roundSelectedCard_) {
    $(".card", this.roundSelectedCard_.getElement()).removeClass("selected");
  }

  // if the user clicked on the same card, deselect it.
  if (card == this.roundSelectedCard_) {
    this.roundSelectedCard_ = null;
    $(".confirm_card", this.element_).attr("disabled", "disabled");
  } else {
    this.roundSelectedCard_ = card;
    $(".card", card.getElement()).addClass("selected");
    $(".confirm_card", this.element_).removeAttr("disabled");
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
  // TODO make the button go disabled
  cah.Ajax.build(cah.$.AjaxOperation.START_GAME).withGameId(this.id_).run();
};

cah.Game.prototype.startGameComplete = function() {
  $("#start_game").hide();
};

cah.Game.prototype.playCardComplete = function() {
  if (this.handSelectedCard_) {
    $(".card", this.handSelectedCard_.getElement()).removeClass("selected");
    // TODO support for multiple play
    this.myPlayedCard_ = this.handSelectedCard_;
    this.removeCardFromHand(this.handSelectedCard_);
    this.addRoundWhiteCard_(this.handSelectedCard_);
    this.handSelectedCard_ = null;
  }
  $(".confirm_card", this.element_).attr("disabled", "disabled");
};

/**
 * Free resources used by this game and remove from the document.
 */
cah.Game.prototype.dispose = function() {
  $(this.element_).remove();
  $(this.scoreboardElement_).remove();
  $("#leave_game").unbind().hide();
  $("#start_game").unbind().hide();
  $(window).off("resize.game_" + this.id_);
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

/**
 * The game state has changed.
 * 
 * @param {Object}
 *          data Data from server.
 */
cah.Game.prototype.stateChange = function(data) {
  this.state_ = data[cah.$.LongPollResponse.GAME_STATE];

  $(".scorecard", this.scoreboardElement_).removeClass("selected");

  switch (this.state_) {
    case cah.$.GameState.LOBBY:
      var handCount = this.hand_.length;
      for ( var i = 0; i < handCount; i++) {
        this.removeCardFromHand(this.hand_[0]);
      }
      this.handSelectedCard_ = null;
      this.myPlayedCard_ = null;
      this.judge_ = null;
      $(".confirm_card", this.element_).attr("disabled", "disabled");
      $(".game_black_card", this.element_).empty();
      for ( var index in this.roundCards_) {
        $(this.roundCards_[index]).off(".round");
      }
      this.roundCards_ = {};
      $(".game_white_cards", this.element_).empty();
      break;

    case cah.$.GameState.PLAYING:
      this.refreshGameStatus();
      this.setBlackCard(data[cah.$.LongPollResponse.BLACK_CARD]);
      break;

    case cah.$.GameState.JUDGING:
      $(".game_white_cards", this.element_).empty();
      this.setRoundWhiteCards(data[cah.$.LongPollResponse.WHITE_CARDS]);
      break;

    default:
      cah.log.error("Game " + this.id_ + " changed to unknown state " + this.state_);
      return;
  }
};

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
  $(".scorecard_score", this.element_).text(score);
  $(".scorecard_status", this.element_).text(cah.$.GamePlayerStatus_msg[status]);
  $(".scorecard_s", this.element_).text(score == 1 ? "" : "s");
};

/**
 * @returns {cah.$.GamePlayerStatus} The status of the player represented by this panel.
 */
cah.GameScorePanel.prototype.getStatus = function() {
  return this.status_;
};

/**
 * confirm card as judge without selecting a round card did ... something
 * 
 * don't always see your card after playing it
 */
