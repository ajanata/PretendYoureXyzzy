/*
 * Copyright (c) 2012-2018, Andy Janata
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
 * Class to manage the game interface.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 * @param {Number}
 *          id The game id.
 * @constructor
 */
cah.Game = function(id) {
  /**
   * The game id.
   * 
   * @type {Number}
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
   * The first spectator element within the scoreboard.
   * 
   * @type {HTMLDivElement}
   * @private
   */
  this.firstSpectatorElement_ = null;

  /**
   * The element for the chat room for this game
   * 
   * @type {HTMLDivElement}
   * @private
   */
  this.chatElement_ = $("#tab-global").clone()[0];
  this.chatElement_.id = "tab-chat-game_" + this.id_;
  $(".chat_submit", this.chatElement_).click(chatsubmit_click(this.id_, this.chatElement_));
  $(".chat", this.chatElement_).keyup(chat_keyup($(".chat_submit", this.chatElement_)));
  // TODO make it not even copy this in the first place
  $(".log", this.chatElement_).empty();

  /**
   * The element for the game options for this game.
   * 
   * @type {HTMLDivElement}
   * @private
   */
  this.optionsElement_ = $("#game_options_template").clone()[0];
  this.optionsElement_.id = "game_options_" + id;
  // TODO: It looks like I'm not changing the id on the label elements...
  $("#score_limit_template_label", this.optionsElement_).attr("for", "score_limit_" + id);
  $("#player_limit_template_label", this.optionsElement_).attr("for", "player_limit_" + id);
  $("#spectator_limit_template_label", this.optionsElement_).attr("for", "spectator_limit_" + id);
  $("#card_set_template_label", this.optionsElement_).attr("for", "card_set_" + id);
  $("#game_password_template_label", this.optionsElement_).attr("for", "game_password_" + id);
  $("#game_hide_password_template_label", this.optionsElement_).attr("for",
      "game_hide_password_" + id);
  $("#timer_multiplier_template_label", this.optionsElement_).attr("for", "timer_multiplier_" + id);

  $("#score_limit_template", this.optionsElement_).attr("id", "score_limit_" + id);
  $("#player_limit_template", this.optionsElement_).attr("id", "player_limit_" + id);
  $("#spectator_limit_template", this.optionsElement_).attr("id", "spectator_limit_" + id);
  $("#card_set_template", this.optionsElement_).attr("id", "card_set_" + id);
  $("#game_password_template", this.optionsElement_).attr("id", "game_password_" + id);
  $("#game_fake_password_template", this.optionsElement_).attr("id", "game_fake_password_" + id);
  $("#game_hide_password_template", this.optionsElement_).attr("id", "game_hide_password_" + id);
  $("#timer_multiplier_template", this.optionsElement_).attr("id", "timer_multiplier_" + id);
  $("#blanks_limit_template", this.optionsElement_).attr("id", "blanks_limit_" + id);

  for ( var key in cah.CardSet.byWeight) {
    /** @type {cah.CardSet} */
    var cardSet = cah.CardSet.byWeight[key];
    var cardSetElementId = 'card_set_' + this.id_ + '_' + cardSet.getId();
    var title = cardSet.getDescription() + ' ' + cardSet.getBlackCardCount() + ' black card'
        + (cardSet.getBlackCardCount() == 1 ? '' : 's') + ', ' + cardSet.getWhiteCardCount()
        + ' white card' + (cardSet.getWhiteCardCount() == 1 ? '' : 's') + '.';
    var aria_label = cardSet.getName() + '. ' + title;
    // that space at the beginning matters
    var html = ' <span class="nowrap"><input type="checkbox" id="' + cardSetElementId
        + '" class="card_set" title="' + title + '" value="' + cardSet.getId()
        + '" name="card_set" aria-label="' + aria_label + '" /><label for="' + cardSetElementId
        + '" title="' + title + '" class="card_set_label">' + cardSet.getName() + '</label></span>';
    if (cardSet.isBaseDeck()) {
      $(".base_card_sets", this.optionsElement_).append(html);
    } else {
      $(".extra_card_sets", this.optionsElement_).append(html);
    }
  }

  $("label", this.optionsElement_).removeAttr("id");
  $(".game_options", this.element_).replaceWith(this.optionsElement_);

  /**
   * The nickname of the host of this game.
   * 
   * @type {String}
   * @private
   */
  this.host_ = "";

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
   * Map of id to card object arrays for round cards.
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
   * The black card for the current round.
   * 
   * @type {cah.card.BlackCard}
   * @private
   */
  this.blackCard_ = null;

  /**
   * The black card for the previous round.
   * 
   * @type {cah.card.BlackCard}
   * @private
   */
  this.lastBlackCard_ = null;

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
   * The name of the judge of the current round.
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

  /**
   * Whether we are showing the result of the last round.
   * 
   * @type {Boolean}
   * @private
   */
  this.showingLastRound_ = false;

  /**
   * Whether we are showing the options or the game.
   * 
   * @type {Boolean}
   * @private
   */
  this.showingOptions_ = true;

  /**
   * Whether the player can select a card right now or not. This is disabled while waiting for the
   * server to respond.
   * 
   * @type {Boolean}
   * @private
   */
  this.canSelectCard_ = true;

  $("#leave_game").click(cah.bind(this, this.leaveGameClick_));
  $("#start_game").click(cah.bind(this, this.startGameClick_));
  $("#stop_game").click(cah.bind(this, this.stopGameClick_));
  $(".confirm_card", this.element_).click(cah.bind(this, this.confirmClick_));
  $(".game_show_last_round", this.element_).click(cah.bind(this, this.showLastRoundClick_));
  $(".game_show_options", this.element_).click(cah.bind(this, this.showOptionsClick_));
  $("select", this.optionsElement_).change(cah.bind(this, this.optionChanged_));
  $("input", this.optionsElement_).blur(cah.bind(this, this.optionChanged_));
  $(".timer_multiplier", this.optionsElement_).change(cah.bind(this, this.optionChanged_));
  $(".card_set", this.optionsElement_).change(cah.bind(this, this.optionChanged_));
  $(".game_hide_password", this.optionsElement_).click(cah.bind(this, this.showOrHidePassword_));

  $(window).on("resize.game_" + this.id_, cah.bind(this, this.windowResize_));
};

/**
 * Load game data from the server and display the game lobby.
 * 
 * TODO reload round win state
 * 
 * @param {Number}
 *          gameId The game id.
 * @param {Object}
 *          data The data returned by the server.
 */
cah.Game.joinGame = function(gameId, data) {
  cah.Ajax.build(cah.$.AjaxOperation.GET_GAME_INFO).withGameId(gameId).run();
  cah.Ajax.build(cah.$.AjaxOperation.GET_CARDS).withGameId(gameId).run();
  cah.Ajax.build(cah.$.AjaxOperation.CARDCAST_LIST_CARDSETS).withGameId(gameId).run();
  cah.GameList.instance.hide();
  var game = new cah.Game(gameId);
  cah.currentGames[gameId] = game;
  game.insertIntoDocument();
  game.showGamePermalink_(data);

  cah.updateHash('game=' + gameId);
  if (!cah.GAME_CHAT_ENABLED) {
    cah.log.status_with_game(game, "IMPORTANT: Game chat has been disabled.", "error");
  }
};

/**
 * Show the permanent link to this game, if it is in the provider server data.
 * 
 * @param {Object}
 *          data The data returned by the server, from either an AJAX call or an long poll response.
 */
cah.Game.prototype.showGamePermalink_ = function(data) {
  if (cah.$.AjaxResponse.GAME_PERMALINK in data) {
    cah.log.status_with_game(this, "<a href='" + data[cah.$.AjaxResponse.GAME_PERMALINK] +
        "' rel='noopener' target='_blank'>Permanent link to this game's rounds.</a>", undefined,
        true);
  }
}

/**
 * Toggle showing the previous round result.
 * 
 * @private
 */
cah.Game.prototype.showLastRoundClick_ = function() {
  if (this.showingLastRound_) {
    $(".game_show_last_round", this.element_).attr("value", "Show Last Round");
    $(".game_black_card_round_indicator", this.element_).text("this round is");
    $(".game_black_card", this.element_).empty().append(this.blackCard_.getElement());
    $(".game_white_card_wrapper", this.element_).removeClass("hide");
    $(".game_last_round", this.element_).addClass("hide");
  } else {
    $(".game_show_last_round", this.element_).attr("value", "Show Current Round");
    $(".game_black_card_round_indicator", this.element_).text("last round was");
    $(".game_black_card", this.element_).empty().append(this.lastBlackCard_.getElement());
    $(".game_white_card_wrapper", this.element_).addClass("hide");
    $(".game_last_round", this.element_).removeClass("hide");
  }

  this.showingLastRound_ = !this.showingLastRound_;
};

/**
 * Toggle showing the game's options.
 * 
 * @private
 */
cah.Game.prototype.showOptionsClick_ = function() {
  if (this.showingOptions_) {
    this.showOptions_();
  } else {
    this.hideOptions_();
  }
  this.showingOptions_ = !this.showingOptions_;
};

/**
 * Show or hide the game's password, based on the value of the checkbox.
 * 
 * @private
 */
cah.Game.prototype.showOrHidePassword_ = function() {
  if ($(".game_hide_password", this.optionsElement_).attr("checked")) {
    $(".game_password", this.optionsElement_).hide();
    $(".game_fake_password", this.optionsElement_).show();
    $(".game_fake_password", this.optionsElement_).attr("value",
        $(".game_password", this.optionsElement_).attr("value"));
    $(".game_fake_password", this.optionsElement_).attr("disabled", "disabled");
  } else {
    $(".game_password", this.optionsElement_).show();
    $(".game_fake_password", this.optionsElement_).hide();
  }
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
  this.blackCard_.setWatermark(card[cah.$.BlackCardData.WATERMARK]);
  this.blackCard_.setDraw(card[cah.$.BlackCardData.DRAW]);
  this.blackCard_.setPick(card[cah.$.BlackCardData.PICK]);

  if (1 != card[cah.$.BlackCardData.PICK] && this.judge_ != cah.nickname) {
    cah.log.status_with_game(this, "Play " + card[cah.$.BlackCardData.PICK]
        + " cards, in the order you wish them to be judged.");
  }

  if (!this.showingLastRound_) {
    $(".game_black_card", this.element_).empty().append(this.blackCard_.getElement());
  }
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
    card.setWatermark(thisCard[cah.$.WhiteCardData.WATERMARK]);
    card.setIsBlankCard(thisCard[cah.$.WhiteCardData.WRITE_IN]);
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
  $(".game_hand_cards", this.element_).append(element);

  $(element).css("transform-origin", "0 0");

  var data = {
    card : card,
  };
  $(element).on("mouseenter.hand", data, cah.bind(this, this.handCardMouseEnter_)).on(
      "mouseleave.hand", data, cah.bind(this, this.handCardMouseLeave_)).on("click.hand", data,
      cah.bind(this, this.handCardClick_)).on("keypress.hand", data,
      cah.bind(this, this.handCardKeypress_));

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
 * Remove all cards from the screen.
 */
cah.Game.prototype.removeAllCards = function() {
  var handCount = this.hand_.length;
  for (var i = 0; i < handCount; i++) {
    this.removeCardFromHand(this.hand_[0]);
  }
  this.handSelectedCard_ = null;
  $(".confirm_card", this.element_).attr("disabled", "disabled");
  $(".game_black_card", this.element_).empty();
  for ( var index in this.roundCards_) {
    $(this.roundCards_[index]).off(".round");
  }
  this.roundCards_ = {};
  $(".game_white_cards", this.element_).empty();
};

/**
 * Set the round white cards.
 * 
 * @param {Array}
 *          cardSets Array of arrays of cah.$.WhiteCardData to display.
 */
cah.Game.prototype.setRoundWhiteCards = function(cardSets) {
  for ( var setIndex in cardSets) {
    var thisSet = Array();
    for ( var index in cardSets[setIndex]) {
      var cardData = cardSets[setIndex][index];
      var card;
      var id = cardData[cah.$.WhiteCardData.ID];
      if (id != -1) {
        card = new cah.card.WhiteCard(true, id);
        card.setText(cardData[cah.$.WhiteCardData.TEXT]);
        card.setWatermark(cardData[cah.$.WhiteCardData.WATERMARK]);
      } else {
        card = new cah.card.WhiteCard();
      }
      thisSet.push(card);
    }
    this.addRoundWhiteCard_(thisSet);
  }
};

/**
 * Add a white card to the round white cards area.
 * 
 * @param {Array}
 *          cards Array of cah.card.WhiteCard to add to area.
 * @private
 */
cah.Game.prototype.addRoundWhiteCard_ = function(cards) {
  var parentElem;
  if (cards.length > 1) {
    parentElem = $("#game_white_cards_binder_template").clone()[0];
    parentElem.id = "";
    $(parentElem).removeClass("hide");
    $(".game_white_cards", this.element_).append(parentElem);
  } else {
    parentElem = $(".game_white_cards", this.element_)[0];
  }

  for ( var index in cards) {
    var card = cards[index];

    var element = card.getElement();
    $(parentElem).append(element);
    $(element).css("transform-origin", "0 0");

    var data = {
      card : card,
    };
    $(element).on("mouseenter.round", data, cah.bind(this, this.roundCardMouseEnter_)).on(
        "mouseleave.round", data, cah.bind(this, this.roundCardMouseLeave_)).on("click.round",
        data, cah.bind(this, this.roundCardClick_)).on("keypress.round", data,
        cah.bind(this, this.roundCardKeypress_));

  }
  this.roundCards_[cards[0].getServerId()] = cards;

  this.resizeRoundCards_();
};

/**
 * Event handler for hand card mouse enter.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.handCardMouseEnter_ = function(e) {
  if (!$(".game_animate_cards", this.element_).attr("checked")) {
    return;
  }
  $(e.data.card.getElement()).css("z-index", "400").animate({
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
  if (!$(".game_animate_cards", this.element_).attr("checked")) {
    return;
  }
  $(e.data.card.getElement()).css("z-index", "201").animate({
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
    "z-index" : 200,
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
  var data = {
    class : ".game_hand_cards",
    cardSmallSize : this.handCardSmallSize_,
    cardLargeSize : this.handCardLargeSize_,
    cardSmallScale : this.handCardSmallScale_,
    cardLargeScale : this.handCardLargeScale_,
    maxSmallSize : 150,
    minSmallSize : 66,
    smallSize : function() {
      return ($(".game_hand_cards", this.element_).width() - 20)
          / ($(".game_hand_cards .card_holder", this.element_).length + 1);
    },
  };
  this.resizeCardHelper_(data);
  this.handCardSmallSize_ = data.cardSmallSize;
  this.handCardLargeSize_ = data.cardLargeSize;
  this.handCardSmallScale_ = data.cardSmallScale;
  this.handCardLargeScale_ = data.cardLargeScale;
};

/**
 * Resize cards in the round white cards are to fit window size and number of players.
 * 
 * TODO This will need some more consideration when there are multiple cards played per player,
 * though it seems to mostly work.
 * 
 * @private
 */
cah.Game.prototype.resizeRoundCards_ = function() {
  $(".game_right_side", this.element_).width(
      $(window).width() - $(".game_left_side", this.element_).width() - 30);
  var data = {
    class : ".game_white_cards",
    cardSmallSize : this.roundCardSmallSize_,
    cardLargeSize : this.roundCardLargeSize_,
    cardSmallScale : this.roundCardSmallScale_,
    cardLargeScale : this.roundCardLargeScale_,
    maxSmallSize : 236,
    minSmallSize : 118,
    smallSize : function() {
      return ($(window).width() - $(".game_left_side", this.element_).width() - 60)
          / $(".game_white_cards .card_holder", this.element_).length;
    },
  };
  this.resizeCardHelper_(data);
  this.roundCardSmallSize_ = data.cardSmallSize;
  this.roundCardLargeSize_ = data.cardLargeSize;
  this.roundCardSmallScale_ = data.cardSmallScale;
  this.roundCardLargeScale_ = data.cardLargeScale;
};

/**
 * Helper for resizing cards, so the logic only needs to be in one place.
 * 
 * @param {Object}
 *          data In/out. Scale, size, and callback helper.
 * @private
 */
cah.Game.prototype.resizeCardHelper_ = function(data) {
  var elems = $(data.class + " .card_holder", this.element_);

  data.cardSmallSize = data.smallSize();
  if (data.cardSmallSize > data.maxSmallSize) {
    data.cardSmallSize = data.maxSmallSize;
  }
  if (data.cardSmallSize < data.minSmallSize) {
    data.cardSmallSize = data.minSmallSize;
  }
  var maxScale = 236 / data.cardSmallSize;
  var scale = maxScale < 1.8 ? maxScale : 1.8;
  data.cardLargeSize = data.cardSmallSize * scale;
  if (data.cardLargeSize > 236) {
    data.cardLargeSize = 236;
  }
  data.cardSmallScale = data.cardSmallSize / 236;
  data.cardLargeScale = data.cardSmallScale * scale;
  if (data.cardLargeScale > maxScale) {
    data.cardLargeScale = maxScale;
  }
  elems.width(data.cardSmallSize).height(data.cardSmallSize).animate({
    scale : data.cardSmallScale,
  }, {
    duration : 0,
  });
};

/**
 * Insert this game into the document.
 */
cah.Game.prototype.insertIntoDocument = function() {
  $("#main_holder").empty().append(this.element_);
  $("#info_area").empty().append(this.scoreboardElement_);
  $("#leave_game").show();

  var linkToChatArea = $("<a>");
  this.gameChatTab_ = $("<li>");
  linkToChatArea.attr("href", "#" + this.chatElement_.id);
  linkToChatArea.text("Chat with game members");
  linkToChatArea.addClass("tab-button");
  this.gameChatTab_.append(linkToChatArea);
  $("#tabs ul").append(this.gameChatTab_);
  $("#tabs").append(this.chatElement_);
  $("#tabs").tabs("refresh");

  linkToChatArea.click();
  this.windowResize_();
  // TODO display a loading animation
};

/**
 * Display a message that a Cardcast deck has been added to the game.
 * 
 * @param {object}
 *          data Payload from server.
 */
cah.Game.prototype.addCardcastDeck = function(data) {
  this.displayCardcastDeckMessage_(data[cah.$.LongPollResponse.CARDCAST_DECK_INFO], "Added");
};

/**
 * Display a message that a Cardcast deck has been removed from the game.
 * 
 * @param {object}
 *          data Payload from server.
 */
cah.Game.prototype.removeCardcastDeck = function(data) {
  this.displayCardcastDeckMessage_(data[cah.$.LongPollResponse.CARDCAST_DECK_INFO], "Removed");
};

/**
 * Display a list of currently in-use Cardcast decks.
 * 
 * @param {array}
 *          data Array of CardSetDatas.
 */
cah.Game.prototype.listCardcastDecks = function(cardSets) {
  cah.log.status_with_game(this, "The following <a target='_blank'"
      + " href='http://www.cardcastgame.com'>Cardcast</a> decks are in use in this game (<a"
      + " target='_blank' href='https://github.com/ajanata/PretendYoureXyzzy/wiki/Cardcast'>"
      + "instructions</a>):", 'admin', true);
  for ( var key in cardSets) {
    var cardSetData = cardSets[key];
    this.displayCardcastDeckMessage_(cardSetData, "In use");
  }
};

/**
 * Display a message about a Cardcast deck.
 * 
 * @param {object}
 *          deckInfo The CardSetData of the deck.
 * @param {string}
 *          verb Verb to display at the beginning of the message: "Added", "Removed", "In use", etc.
 * @private
 */
cah.Game.prototype.displayCardcastDeckMessage_ = function(deckInfo, verb) {
  var code = ("00000" + (-1 * deckInfo[cah.$.CardSetData.ID]).toString(36).toUpperCase()).slice(-5);
  var str = verb + ": Cardcast deck '" + deckInfo[cah.$.CardSetData.CARD_SET_NAME]
      + "' (code: <a target='_blank' href='http://www.cardcastgame.com/browse/deck/" + code + "'> "
      + code + "</a>), with " + deckInfo[cah.$.CardSetData.BLACK_CARDS_IN_DECK]
      + " black cards and " + deckInfo[cah.$.CardSetData.WHITE_CARDS_IN_DECK] + " white cards.";
  cah.log.status_with_game(this, str, 'admin', true);
};

/**
 * Update game status display.
 * 
 * @param {Object}
 *          data Game data returned from server.
 */
cah.Game.prototype.updateGameStatus = function(data) {
  var gameInfo = data[cah.$.AjaxResponse.GAME_INFO];
  var options = gameInfo[cah.$.AjaxResponse.GAME_OPTIONS];
  this.host_ = gameInfo[cah.$.GameInfo.HOST];

  if (this.host_ == cah.nickname && gameInfo[cah.$.GameInfo.STATE] == cah.$.GameState.LOBBY) {
    $("#start_game").show();
  } else {
    $("#start_game").hide();
  }

  if (this.host_ == cah.nickname && gameInfo[cah.$.GameInfo.STATE] != cah.$.GameState.LOBBY) {
    $("#stop_game").show();
  } else {
    $("#stop_game").hide();
  }

  if (gameInfo[cah.$.GameInfo.STATE] == cah.$.GameState.LOBBY) {
    this.showOptions_();
  } else {
    this.hideOptions_();
  }

  $(".score_limit", this.optionsElement_).val(options[cah.$.GameOptionData.SCORE_LIMIT]);
  $(".player_limit", this.optionsElement_).val(options[cah.$.GameOptionData.PLAYER_LIMIT]);
  $(".spectator_limit", this.optionsElement_).val(options[cah.$.GameOptionData.SPECTATOR_LIMIT]);
  $(".game_password", this.optionsElement_).val(options[cah.$.GameOptionData.PASSWORD]);
  $(".timer_multiplier", this.optionsElement_).val(options[cah.$.GameOptionData.TIMER_MULTIPLIER]);

  var cardSetIds = options[cah.$.GameOptionData.CARD_SETS];// .split(',');
  $(".card_set", this.optionsElement_).removeAttr("checked");
  for ( var key in cardSetIds) {
    var cardSetId = cardSetIds[key];
    $("#card_set_" + this.id_ + "_" + cardSetId, this.optionsElement_).attr("checked", "checked");
  }
  $(".blanks_limit", this.optionsElement_).val(options[cah.$.GameOptionData.BLANKS_LIMIT]);

  var playerInfos = data[cah.$.AjaxResponse.PLAYER_INFO];
  for ( var index in playerInfos) {
    this.updateUserStatus(playerInfos[index]);
  }

  var spectators = gameInfo[cah.$.GameInfo.SPECTATORS];
  for ( var index in spectators) {
    this.updateSpectator(spectators[index]);
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
    if (this.firstSpectatorElement_) {
      $(this.firstSpectatorElement_).before(panel.getElement());
    } else {
      $(this.scoreboardElement_).append(panel.getElement());
    }
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
      this.handSelectedCard_ = null;
      $(".selected", $(".game_hand", this.element_)).removeClass("selected");
    }

    if (playerStatus == cah.$.GamePlayerStatus.HOST) {
      $("#start_game").show();
    }

    if (playerStatus == cah.$.GamePlayerStatus.JUDGE) {
      $(".game_hand_filter", this.element_).removeClass("hide");
      $(".game_hand_filter_text", this.element_).text(cah.$.GamePlayerStatus_msg_2[playerStatus]);
    } else if (playerStatus == cah.$.GamePlayerStatus.PLAYING) {
      $(".game_hand_filter", this.element_).addClass("hide");
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
      // TODO make this not suck for multiple selection. it only shows one card when they're done.
      // TODO have some sort of way to know, from the server, how far along everybody is playing
      // for multi-play
      this.addRoundWhiteCard_(Array(new cah.card.WhiteCard()));
    }
  }
};

/**
 * Update a single spectator's info.
 * 
 * @param {String}
 *          spectator The spectator name.
 */
cah.Game.prototype.updateSpectator = function(spectator) {
  var panel = this.scoreCards_[spectator];
  if (!panel) {
    // new score panel
    panel = new cah.GameScorePanel(spectator);
    $(this.scoreboardElement_).append(panel.getElement());
    this.scoreCards_[spectator] = panel;
    if (!this.firstSpectatorElement_) {
      this.firstSpectatorElement_ = panel.getElement();
    }
  }
  panel.update(-1, cah.$.GamePlayerStatus.SPECTATOR);

  if (spectator == cah.nickname) {
    $(".game_message", this.element_).text(
        cah.$.GamePlayerStatus_msg_2[cah.$.GamePlayerStatus.SPECTATOR]);
    $(".confirm_card", this.element_).attr("disabled", "disabled");
  }
};

/**
 * Round has completed. Update display of round cards to show winner.
 * 
 * @param {Object}
 *          data Data from server.
 */
cah.Game.prototype.roundComplete = function(data) {
  var cards = this.roundCards_[data[cah.$.LongPollResponse.WINNING_CARD]];
  var ariaText = '';
  for ( var index in cards) {
    var card = cards[index];
    $(".card", card.getElement()).addClass("selected");
    ariaText += card.getAriaText();
  }
  var roundWinner = data[cah.$.LongPollResponse.ROUND_WINNER];
  var scoreCard = this.scoreCards_[roundWinner];
  $(scoreCard.getElement()).addClass("selected");
  $(".confirm_card", this.element_).attr("disabled", "disabled");
  var msg = roundWinner + " wins the round.  The next round will begin in "
      + (data[cah.$.LongPollResponse.INTERMISSION] / 1000) + " seconds.";
  if (cah.$.LongPollResponse.ROUND_PERMALINK in data) {
    msg = msg + " <a href='" + data[cah.$.LongPollResponse.ROUND_PERMALINK]
        + "' rel='noopener' target='_blank'>Permalink</a>";
  }
  cah.log.status_with_game(this, msg, undefined, true);

  // update the previous round display
  $(".game_last_round_winner", this.element_).text(roundWinner);
  $(".game_last_round_cards", this.element_).empty().append(
      $(".game_white_card_wrapper .card_holder", this.element_).clone());
  this.lastBlackCard_ = this.blackCard_;
  $(".game_show_last_round", this.element_).removeAttr("disabled");

  // speak it in screen readers
  cah.log.ariaStatus("The round was won by " + roundWinner + " with " + ariaText);
};

/**
 * Notify the user that they are running out of time to play.
 */
cah.Game.prototype.hurryUp = function() {
  cah.log.status_with_game(this,
      "Hurry up! You have less than 10 seconds to decide, or you will be skipped.");
};

/**
 * A player was kicked due to being idle.
 * 
 * @param {object}
 *          data Event data from server.
 */
cah.Game.prototype.playerKickedIdle = function(data) {
  cah.log.status_with_game(this, data[cah.$.LongPollResponse.NICKNAME]
      + " was kicked for being idle for too many rounds.");
};

/**
 * A player was skipped due to being idle.
 * 
 * @param {obejct}
 *          data Event data from server.
 */
cah.Game.prototype.playerSkipped = function(data) {
  cah.log.status_with_game(this, data[cah.$.LongPollResponse.NICKNAME]
      + " was skipped this round for being idle for too long.");
};

/**
 * Notify the player that a deck has been reshuffled.
 * 
 * @param {String}
 *          deck Deck name which has been reshuffled.
 */
cah.Game.prototype.reshuffle = function(deck) {
  cah.log.status_with_game(this, "The " + deck + " deck has been reshuffled.");
};

/**
 * Notify the player that the judge has left the game and cards are being returned to hands.
 * 
 * @param {object}
 *          data Event data from the server.
 */
cah.Game.prototype.judgeLeft = function(data) {
  cah.log.status_with_game(this,
      "The Card Czar has left the game. Cards played this round are being returned to hands.");
  cah.log.status_with_game(this, "The next round will begin in "
      + (data[cah.$.LongPollResponse.INTERMISSION] / 1000) + " seconds.");
  cah.log.status_with_game(this, "(Displayed state will look weird until the next round.)");
};

/**
 * The judge was skipped for taking too long.
 */
cah.Game.prototype.judgeSkipped = function() {
  cah.log.status_with_game(this, "The Card Czar has taken too long to decide and has been skipped."
      + " Cards played this round are being returned to hands.");
};

/**
 * Event handler for confirm selection button.
 * 
 * @private
 */
cah.Game.prototype.confirmClick_ = function() {
  if (this.judge_ == cah.nickname) {
    if (this.roundSelectedCard_ != null) {
      cah.Ajax.build(cah.$.AjaxOperation.JUDGE_SELECT).withGameId(this.id_).withCardId(
          this.roundSelectedCard_.getServerId()).run();
    }
  } else {
    if (this.handSelectedCard_ != null) {
      var ajax = cah.Ajax.build(cah.$.AjaxOperation.PLAY_CARD).withGameId(this.id_).withCardId(
          this.handSelectedCard_.getServerId());
      if (this.handSelectedCard_.isBlankCard()) {
        // blank card
        var text = prompt("What would you like this card to say?", "");
        if (text == null || text == '') {
          return;
        }
        text = $("<div/>").text(text).html(); // html sanitise
        this.handSelectedCard_.setText(text);
        ajax = ajax.withMessage(text);
      }
      ajax.run();
    }
  }
  this.disableCardControls_();
};

/**
 * Event handler for pressing a key on a card in the hand.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.handCardKeypress_ = function(e) {
  if (32 == e.which) {
    this.handCardClick_(e);
  }
};

/**
 * Event handler for clicking on a card in the hand.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.handCardClick_ = function(e) {
  if (!this.canSelectCard_) {
    return;
  }
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
    cah.log.ariaStatus("Deselected card.");
  } else {
    this.handSelectedCard_ = card;
    $(".card", card.getElement()).addClass("selected");
    $(".confirm_card", this.element_).removeAttr("disabled");
    cah.log.ariaStatus("Selected card.");
  }
};

/**
 * Event handler for pressing a key on a card in the round.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.roundCardKeypress_ = function(e) {
  if (32 == e.which) {
    this.roundCardClick_(e);
  }
};

/**
 * Event handler for clicking on a card in the round.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.roundCardClick_ = function(e) {
  if (!this.canSelectCard_) {
    return;
  }
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
    cah.log.ariaStatus("Deselected card.");
  } else {
    this.roundSelectedCard_ = card;
    $(".card", card.getElement()).addClass("selected");
    $(".confirm_card", this.element_).removeAttr("disabled");
    cah.log.ariaStatus("Selected card.");
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
  if (confirm("Are you sure you wish to leave the game?")) {
    cah.Ajax.build(cah.$.AjaxOperation.LEAVE_GAME).withGameId(this.id_).run();
    $(this.chatElement_).detach();
    $(this.gameChatTab_).detach();
    $("#tabs").tabs("refresh");
  }
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

/**
 * Called when the call to the server to start the game has completed successfully.
 */
cah.Game.prototype.startGameComplete = function() {
  $("#start_game").hide();
};

/**
 * Event handler for stop game button.
 * 
 * @private
 */
cah.Game.prototype.stopGameClick_ = function() {
  cah.Ajax.build(cah.$.AjaxOperation.STOP_GAME).withGameId(this.id_).run();
};

/**
 * Called when the call to the server to play a card has completed successfully.
 */
cah.Game.prototype.playCardComplete = function() {
  if (this.handSelectedCard_) {
    $(".card", this.handSelectedCard_.getElement()).removeClass("selected");
    // TODO support for multiple play, though it seems to be working now...
    this.removeCardFromHand(this.handSelectedCard_);
    this.addRoundWhiteCard_(Array(this.handSelectedCard_));
    this.handSelectedCard_ = null;
  }
  $(".confirm_card", this.element_).attr("disabled", "disabled");
  this.enableCardControls_();
};

/**
 * Called when an error ocurred while playing a card.
 */
cah.Game.prototype.playCardError = function() {
  this.enableCardControls_();
};

/**
 * Enable playing cards, etc.
 * 
 * @private
 */
cah.Game.prototype.enableCardControls_ = function() {
  this.canSelectCard_ = true;
};

/**
 * Disable playing cards, etc.
 * 
 * @private
 */
cah.Game.prototype.disableCardControls_ = function() {
  this.canSelectCard_ = false;
};

/**
 * Free resources used by this game and remove from the document.
 */
cah.Game.prototype.dispose = function() {
  $(this.element_).remove();
  $(this.scoreboardElement_).remove();
  $("#leave_game").unbind().hide();
  $("#start_game").unbind().hide();
  $("#stop_game").unbind().hide();
  $(window).off("resize.game_" + this.id_);

  cah.updateHash('');
};

/**
 * A player has joined the game.
 * 
 * @param {String}
 *          player Player that joined.
 */
cah.Game.prototype.playerJoin = function(player) {
  if (player != cah.nickname) {
    cah.log.status_with_game(this, player + " has joined the game.");
    this.refreshGameStatus();
  } else {
    cah.log.status_with_game(this, "You have joined the game.");
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
    cah.log.status_with_game(this, player + " has left the game.");
    this.refreshGameStatus();
  } else {
    cah.log.status_with_game(this, "You have left the game.");
  }
  var scorecard = this.scoreCards_[player];
  if (scorecard) {
    $(scorecard.getElement()).remove();
  }
  delete this.scoreCards_[player];
};

/**
 * A spectator has joined the game.
 * 
 * @param {String}
 *          spectator Spectator that joined.
 */
cah.Game.prototype.spectatorJoin = function(spectator) {
  if (spectator != cah.nickname) {
    cah.log.status_with_game(this, spectator + " has started spectating the game.");
    this.refreshGameStatus();
  } else {
    cah.log.status_with_game(this, "You have started spectating the game.");
  }
  this.updateSpectator(spectator);
};

/**
 * A spectator has left the game.
 * 
 * @param {String}
 *          spectator Spectator that left.
 */
cah.Game.prototype.spectatorLeave = function(spectator) {
  if (spectator != cah.nickname) {
    cah.log.status_with_game(this, spectator + " has stopped spectating the game.");
    this.refreshGameStatus();
  } else {
    cah.log.status_with_game(this, "You have stopped spectating the game.");
  }
  var scorecard = this.scoreCards_[spectator];
  if (scorecard) {
    if (this.firstSpectatorElement_ == scorecard.getElement()) {
      this.firstSpectatorElement_ = this.firstSpectatorElement_.nextSibling;
    }
    $(scorecard.getElement()).remove();
  }
  delete this.scoreCards_[spectator];
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
      this.removeAllCards();
      this.judge_ = null;
      $(".game_hand_filter", this.element_).addClass("hide"); // in case they were the judge last
      $("#stop_game").hide();
      // round
      this.showOptions_();

      break;

    case cah.$.GameState.PLAYING:
      $(".game_white_cards", this.element_).empty();
      this.enableCardControls_();
      this.hideOptions_();
      this.refreshGameStatus();
      this.setBlackCard(data[cah.$.LongPollResponse.BLACK_CARD]);
      this.showGamePermalink_(data);
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

/**
 * Hide the options panel.
 * 
 * @private
 */
cah.Game.prototype.hideOptions_ = function() {
  $(".game_show_options", this.element_).val("Show Game Options");
  $(".game_options", this.element_).addClass("hide");
  $(".game_right_side", this.element_).removeClass("hide");
};

/**
 * Show the options panel. Enables or disables the controls based on whether we are the host.
 * 
 * @private
 */
cah.Game.prototype.showOptions_ = function() {
  $(".game_show_options", this.element_).val("Hide Game Options");
  $(".game_options", this.element_).removeClass("hide");
  $(".game_right_side", this.element_).addClass("hide");
  this.updateOptionsEnabled_();
};

/**
 * Enable or disable the option controls depending on whether we are the host.
 * 
 * @private
 */
cah.Game.prototype.updateOptionsEnabled_ = function() {
  if (this.host_ == cah.nickname && this.state_ == cah.$.GameState.LOBBY) {
    $("select", this.optionsElement_).removeAttr("disabled");
    $("input", this.optionsElement_).removeAttr("disabled");
    $(".options_host_only", this.optionsElement_).addClass("hide");
  } else {
    $("select", this.optionsElement_).attr("disabled", "disabled");
    $("input", this.optionsElement_).attr("disabled", "disabled");
    $(".options_host_only", this.optionsElement_).removeClass("hide");
    // let all players adjust the "hide password" option themselves
    $(".game_hide_password", this.optionsElement_).removeAttr("disabled");
  }
};

/**
 * Event handler for changing an option.
 * 
 * @param e
 * @private
 */
cah.Game.prototype.optionChanged_ = function(e) {
  // don't update the server for the 'hide password' option
  if (e.target.classList.contains('game_hide_password')) {
    return;
  }

  var selectedCardSets = $(".card_sets :checked", this.optionsElement_);
  var cardSetIds = [];
  for (var i = 0; i < selectedCardSets.length; i++) {
    cardSetIds.push(selectedCardSets[i].value);
  }
  var options = {};
  options[cah.$.GameOptionData.CARD_SETS] = cardSetIds.join(',');
  options[cah.$.GameOptionData.SCORE_LIMIT] = $(".score_limit", this.optionsElement_).val();
  options[cah.$.GameOptionData.PLAYER_LIMIT] = $(".player_limit", this.optionsElement_).val();
  options[cah.$.GameOptionData.SPECTATOR_LIMIT] = $(".spectator_limit", this.optionsElement_).val();
  options[cah.$.GameOptionData.PASSWORD] = $(".game_password", this.optionsElement_).val();
  options[cah.$.GameOptionData.BLANKS_LIMIT] = $(".blanks_limit", this.optionsElement_).val();
  options[cah.$.GameOptionData.TIMER_MULTIPLIER] = $('.timer_multiplier', this.optionsElement_)
      .val();

  cah.Ajax.build(cah.$.AjaxOperation.CHANGE_GAME_OPTIONS).withGameId(this.id_).withGameOptions(
      options).run();
};

/**
 * 
 * @param {object}
 *          data Event data from server.
 */
cah.Game.prototype.optionsChanged = function(data) {
  this.updateGameStatus(data);
};

/**
 * @returns This game's chat element.
 * @type {HTMLDivElement}
 */
cah.Game.prototype.getChatElement = function() {
  return this.chatElement_;
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
  this.element_.id = "";
  $(this.element_).removeClass("hide");

  /**
   * The score on this scorecard.
   * 
   * @type {Number}
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

  $(".scorecard_player", this.element_).text(player);
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
 * @param {Number}
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
  if (score < 0) {
    $(".scorecard_points", this.element_).addClass("hide");
    $(this.element_).attr("aria-label", this.player_ + ". " + cah.$.GamePlayerStatus_msg[status]);
  } else {
    $(".scorecard_points", this.element_).removeClass("hide");
    $(this.element_).attr(
        "aria-label",
        this.player_ + " has " + score + " Awesome Point" + (score == 1 ? "" : "s") + ". "
            + cah.$.GamePlayerStatus_msg[status]);
  }
};

/**
 * @returns {cah.$.GamePlayerStatus} The status of the player represented by this panel.
 */
cah.GameScorePanel.prototype.getStatus = function() {
  return this.status_;
};

/*
 * confirm card as judge without selecting a round card did ... something
 * 
 * don't always see your card after playing it
 */
