/**
 * Builder for ajax data.
 * 
 * @author ajanata
 */

/**
 * Builder for ajax requests. This contains methods to add every possible parameter to an ajax
 * request, even if it doesn't make sense for the operation code.
 * 
 * @param {string}
 *          op The operation code for the ajax request.
 * @returns {cah.ajax.Builder}
 * @constructor
 */
cah.ajax.Builder = function(op) {
  /**
   * The data for this request.
   * 
   * @type {object}
   */
  this.data = {};

  this.data[cah.$.AjaxRequest.OP] = op;

  /**
   * Whether this request has been run or not.
   * 
   * @type {boolean}
   * @private
   */
  this.run_ = false;

  /**
   * Error callback for this request.
   * 
   * @type {?function(jqXHR,textStatus,errorThrown)}
   */
  this.errback = undefined;
};

/**
 * Serial counter for ajax requests.
 * 
 * @type {number}
 */
cah.ajax.Builder.serial = 0;

/**
 * Set an error callback for the request.
 * 
 * @param {Function}
 *          opt_errback Optional error callback. (jqXHR,textStatus,errorThrown)
 * @returns {cah.ajax.Builder}
 */
cah.ajax.Builder.prototype.withErrback = function(opt_errback) {
  this.assertNotExecuted();
  this.errback = errback;
  return this;
};

/**
 * Run the ajax request.
 */
cah.ajax.Builder.prototype.run = function() {
  this.assertNotExecuted();
  this.run_ = true;

  this.data[cah.$.AjaxRequest.SERIAL] = cah.ajax.Builder.serial++;
  cah.Ajax.instance.requestWithBuilder(this);
};

/**
 * @param {string}
 *          nickname Nickname field to use in the request.
 * @returns {cah.ajax.Builder} This object.
 */
cah.ajax.Builder.prototype.withNickname = function(nickname) {
  this.assertNotExecuted();
  this.data[cah.$.AjaxRequest.NICKNAME] = nickname;
  return this;
};

/**
 * @param {string}
 *          message Message field to use in the request.
 * @returns {cah.ajax.Builder} This object.
 */
cah.ajax.Builder.prototype.withMessage = function(message) {
  this.assertNotExecuted();
  this.data[cah.$.AjaxRequest.MESSAGE] = message;
  return this;
};

/**
 * @param {number}
 *          gameId Game id field to use in the request.
 * @returns {cah.ajax.Builder} This object.
 */
cah.ajax.Builder.prototype.withGameId = function(gameId) {
  this.assertNotExecuted();
  this.data[cah.$.AjaxRequest.GAME_ID] = gameId;
  return this;
};

cah.ajax.Builder.prototype.assertNotExecuted = function() {
  if (this.run_) {
    throw "Request already executed.";
  }
};

cah.ajax.Builder.prototype.assertExecuted = function() {
  if (!this.run_) {
    throw "Request not yet executed.";
  }
};

cah.ajax.Builder.prototype.getOp = function() {
  this.assertExecuted();
  return this.data[cah.$.AjaxRequest.OP];
};

cah.ajax.Builder.prototype.getSerial = function() {
  this.assertExecuted();
  return this.data[cah.$.AjaxRequest.SERIAL];
};
