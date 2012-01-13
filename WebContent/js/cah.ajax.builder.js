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

  this.data.op = op;

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
 * @param {?function(jqXHR,textStatus,errorThrown)}
 *          [opt_errback] Optional error callback.
 * @returns {cah.ajax.Builder}
 */
cah.ajax.Builder.prototype.withErrback = function(errback) {
  this.errback = errback;
  return this;
};

/**
 * Run the ajax request.
 */
cah.ajax.Builder.prototype.run = function() {
  this.data.serial = cah.ajax.Builder.serial++;
  cah.Ajax.instance.requestWithBuilder(this);
};

/**
 * @param {string}
 *          nickname Nickname field to use in the request.
 * @returns {cah.ajax.Builder} This object.
 */
cah.ajax.Builder.prototype.withNickname = function(nickname) {
  this.data.nickname = nickname;
  return this;
};

/**
 * @param {string}
 *          message Message field to use in the request.
 * @returns {cah.ajax.Builder} This object.
 */
cah.ajax.Builder.prototype.withMessage = function(message) {
  this.data.message = message;
  return this;
};
