/**
 * Card objects.
 * 
 * @author ajanata
 */

cah.card = {};
cah.card.serial = 0;

/**
 * Base class for cards.
 * 
 * @param {boolean}
 *          opt_faceUp True if this card is initially face-up.
 * @param {number}
 *          opt_id The id of this card, for server communication purposes.
 * 
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

  this.element_ = $('<div id="card_' + this.id_ + '" class="card_holder" ><br/></div>')[0];
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
 * Set the visible text on a card. It matters not if the card is face-up or face-down.
 * 
 * @param {string}
 *          text Text to display on the card.
 */
cah.card.BaseCard.prototype.setText = function(text) {
  this.ensureFaceUpElement_();
  jQuery(".card_text", this.faceUpElem_).text(text);
};

/**
 * Ensure this card has a face-up element, creating one if needed.
 * 
 * @private
 */
cah.card.BaseCard.prototype.ensureFaceUpElement_ = function() {
  if (!this.faceUpElem_) {
    this.faceUpElem_ = this.getFaceUp_();
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
 * @returns {?number} The server ID of this card, if one was specified at creation.
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
};
cah.inherits(cah.card.BlackCard, cah.card.BaseCard);

cah.card.BlackCard.prototype.getFaceDown_ = function() {
  var temp = $("#black_down_template").clone()[0];
  temp.id = "black_down_" + this.id_;
  $(temp).removeClass("hide");
  return temp;
};

cah.card.BlackCard.prototype.getFaceUp_ = function() {
  var temp = $("#black_up_template").clone()[0];
  temp.id = "black_up_" + this.id_;
  $(temp).removeClass("hide");
  return temp;
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
};
cah.inherits(cah.card.WhiteCard, cah.card.BaseCard);

cah.card.WhiteCard.prototype.getFaceDown_ = function() {
  var temp = $("#white_down_template").clone()[0];
  temp.id = "white_down_" + this.id_;
  $(temp).removeClass("hide");
  return temp;
};

cah.card.WhiteCard.prototype.getFaceUp_ = function() {
  var temp = $("#white_up_template").clone()[0];
  temp.id = "white_up_" + this.id_;
  $(temp).removeClass("hide");
  return temp;
};
