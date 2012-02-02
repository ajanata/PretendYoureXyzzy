/**
 * Copyright (c) 2011, Andy Janata
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

/**
 * @param {number}
 *          cardId Card id field to use in the request.
 * @returns {cah.ajax.Builder} This object.
 */
cah.ajax.Builder.prototype.withCardId = function(cardId) {
  this.assertNotExecuted();
  this.data[cah.$.AjaxRequest.CARD_ID] = cardId;
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
