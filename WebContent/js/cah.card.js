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
 * Card objects. There is a base class, and individual classes for White and Black cards. This could
 * probably stand to be split up into 3 files.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */

cah.card = {};
/**
 * Serial number to use in card div IDs. This possibly isn't needed.
 * 
 * @type {Number}
 */
cah.card.serial = 0;

/**
 * Base class for cards.
 * 
 * @param {boolean}
 *          opt_faceUp True if this card is initially face-up.
 * @param {number}
 *          opt_id The id of this card, for server communication purposes.
 * @constructor
 */
cah.card.BaseCard = function(opt_faceUp, opt_id) {
  /**
   * The id to use for html elements for this card.
   * 
   * @type {number}
   * @protected
   */
  this.id_ = cah.card.serial++;

  /**
   * The id of this card, for server communication purposes.
   * 
   * @type {?number}
   * @protected
   */
  this.serverId_ = opt_id;

  /**
   * Whether this card is currently face-up.
   * 
   * @type {boolean}
   * @protected
   */
  this.faceUp_ = !!opt_faceUp;

  /**
   * Element for face-down version of this card. Lazily loaded.
   * 
   * @type {HTMLDivElement}
   * @protected
   */
  this.faceDownElem_ = undefined;

  /**
   * Element for face-up version of this card. Lazily loaded.
   * 
   * @type {HTMLDivElement}
   * @protected
   */
  this.faceUpElem_ = undefined;

  this.element_ = $('<div id="card_' + this.id_ + '" class="card_holder"><br/></div>')[0];
  if (this.faceUp_) {
    this.turnFaceUp();
  } else {
    this.turnFaceDown();
  }
};

/**
 * Replaces this card with its face-up version. If no text has been set on this card, it will need
 * to be set!
 */
cah.card.BaseCard.prototype.turnFaceUp = function() {
  this.ensureFaceUpElement_();
  $(this.element_).empty().append(this.faceUpElem_);
  this.faceUp_ = true;
};

/**
 * Replaces this card with its face-down version. If text has been set on this card, it will still
 * be resident in the object, but the user would have seen the card face-up already anyway.
 */
cah.card.BaseCard.prototype.turnFaceDown = function() {
  this.ensureFaceDownElement_();
  $(this.element_).empty().append(this.faceDownElem_);
  this.faceUp_ = false;
};

/**
 * Get the face-down version of this card.
 * 
 * @protected
 * @abstract
 * @returns {HTMLDivElement} Face-down card element.
 */
cah.card.BaseCard.prototype.getFaceDown_ = function() {
  throw "Abstract method invoked.";
};

/**
 * Get the face-up version of this card.
 * 
 * @protected
 * @abstract
 * @returns {HTMLDivElement} Face-up card element.
 */
cah.card.BaseCard.prototype.getFaceUp_ = function() {
  throw "Abstract method invoked.";
};

/**
 * Set the visible text on a card. It matters not if the card is face-up or face-down. HTML is
 * allowed and entities are required.
 * 
 * @param {string}
 *          text HTML to display on the card.
 */
cah.card.BaseCard.prototype.setText = function(text) {
  this.ensureFaceUpElement_();
  $(".card_text", this.faceUpElem_).html(text);
  // TODO do this better
  $(".card_text", this.faceUpElem_).attr(
      "aria-label",
      text.replace("____", "blank").replace("&trade;", "").replace("&reg;", "").replace("&amp;",
          "and"));
};

/**
 * Gets the screen reader text from this card.
 */
cah.card.BaseCard.prototype.getAriaText = function() {
  return $(".card_text", this.faceUpElem_).attr("aria-label");
};

/**
 * Set the "watermark" on the logo on the card. It matters not if the card is face-up or face-down.
 * 
 * @param {String}
 *          watermark Watermark to display on the card.
 */
cah.card.BaseCard.prototype.setWatermark = function(watermark) {
  this.ensureFaceUpElement_();
  $(".watermark", this.faceUpElem_).text(watermark);
};

/**
 * Ensure this card has a face-up element, creating one if needed.
 * 
 * @private
 */
cah.card.BaseCard.prototype.ensureFaceUpElement_ = function() {
  if (!this.faceUpElem_) {
    this.faceUpElem_ = this.getFaceUp_();
    // TODO move the logo stuff out to static css instead of doing it for every card...
    $(".logo_1", this.faceUpElem_).animate({
      rotate : "-13deg",
    }, {
      duration : 0,
      queue : false,
    });
    $(".logo_3", this.faceUpElem_).animate({
      rotate : "13deg",
    }, {
      duration : 0,
      queue : false,
    });
  }
};

/**
 * Ensure this card has a face-down element, creating one if needed.
 * 
 * @private
 */
cah.card.BaseCard.prototype.ensureFaceDownElement_ = function() {
  if (!this.faceDownElem_) {
    this.faceDownElem_ = this.getFaceDown_();
  }
};

/**
 * @return {?number} The server ID of this card, if one was specified at creation.
 */
cah.card.BaseCard.prototype.getServerId = function() {
  return this.serverId_;
};

/**
 * @return {HTMLElement} The element for this card.
 */
cah.card.BaseCard.prototype.getElement = function() {
  return this.element_;
};

// ///////////////////////////////////////////////

/**
 * Black card definition.
 * 
 * @param {boolean}
 *          opt_faceUp True if this card is initially face-up.
 * @param {number}
 *          opt_id The id of this card, for server communication purposes.
 * @extends cah.card.BaseCard
 * @constructor
 */
cah.card.BlackCard = function(opt_faceUp, opt_id) {
  cah.card.BaseCard.call(this, opt_faceUp, opt_id);

  /**
   * The number of white cards to draw when this is the active black card.
   * 
   * @type {number}
   * @private
   */
  this.draw_ = 0;

  /**
   * The number of white cards to play for this black card.
   * 
   * @type {number}
   * @private
   */
  this.pick_ = 1;
};
cah.inherits(cah.card.BlackCard, cah.card.BaseCard);

/**
 * @override
 */
cah.card.BlackCard.prototype.getFaceDown_ = function() {
  var temp = $("#black_down_template").clone()[0];
  temp.id = "black_down_" + this.id_;
  $(temp).removeClass("hide");
  return temp;
};

/**
 * @override
 */
cah.card.BlackCard.prototype.getFaceUp_ = function() {
  var temp = $("#black_up_template").clone()[0];
  temp.id = "black_up_" + this.id_;
  $(temp).removeClass("hide");
  return temp;
};

/**
 * @param {number}
 *          draw The number of white cards to draw when this black card is played.
 */
cah.card.BlackCard.prototype.setDraw = function(draw) {
  this.draw_ = draw;
  this.updateCardInfo_();
};

/**
 * @param {number}
 *          pick The number of white cards to play for this black card.
 */
cah.card.BlackCard.prototype.setPick = function(pick) {
  this.pick_ = pick;
  this.updateCardInfo_();
};

/**
 * Update the pick and draw displays on this card, and potentially change the game name to or from
 * "CAH".
 * 
 * @private
 */
cah.card.BlackCard.prototype.updateCardInfo_ = function() {
  if (this.draw_ != 0 || this.pick_ != 1) {
    $(".logo_text", this.faceUpElem_).text("PYX");
    if (this.draw_ != 0) {
      $(".draw .card_number", this.faceUpElem_).text(this.draw_);
      $(".draw", this.faceUpElem_).removeClass("hide");
    } else {
      $(".draw", this.faceUpElem_).addClass("hide");
    }

    if (this.pick_ != 1) {
      $(".pick .card_number", this.faceUpElem_).text(this.pick_);
      $(".pick", this.faceUpElem_).removeClass("hide");
    } else {
      $(".pick", this.faceUpElem_).addClass("hide");
    }
  } else {
    $(".logo_text", this.faceUpElem_).text("Pretend You're Xyzzy");
  }
};

// ///////////////////////////////////////////////

/**
 * White card definition.
 * 
 * @param {boolean}
 *          opt_faceUp True if this card is initially face-up.
 * @param {number}
 *          opt_id The id of this card, for server communication purposes.
 * @extends cah.card.BaseCard
 * @constructor
 */
cah.card.WhiteCard = function(opt_faceUp, opt_id) {
  cah.card.BaseCard.call(this, opt_faceUp, opt_id);

  /**
   * Whether this is a fill-in blank card or not.
   * 
   * @type {boolean}
   */
  this.isBlankCard_ = false;
};
cah.inherits(cah.card.WhiteCard, cah.card.BaseCard);

/**
 * Set this card's flag indicating if it is a fill-in blank card.
 * 
 * @param {boolean}
 *          blank Whether this is a fill-in blank card or not.
 */
cah.card.WhiteCard.prototype.setIsBlankCard = function(blank) {
  this.isBlankCard_ = blank;
};

/**
 * Checks if this is a blank card.
 * 
 * @returns True if this is a blank card.
 */
cah.card.WhiteCard.prototype.isBlankCard = function() {
  return this.isBlankCard_;
};

/**
 * @override
 */
cah.card.WhiteCard.prototype.getFaceDown_ = function() {
  var temp = $("#white_down_template").clone()[0];
  temp.id = "white_down_" + this.id_;
  $(temp).removeClass("hide");
  return temp;
};

/**
 * @override
 */
cah.card.WhiteCard.prototype.getFaceUp_ = function() {
  var temp = $("#white_up_template").clone()[0];
  temp.id = "white_up_" + this.id_;
  $(temp).removeClass("hide");
  return temp;
};
