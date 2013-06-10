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
 * AJAX utility functions for cah. Core library. Individual handlers should be elsewhere.
 * 
 * @author ajanata
 */

cah.Ajax = {};
cah.Ajax.instance = {};
cah.ajax = {};
cah.ajax.ErrorHandlers = {};
cah.ajax.SuccessHandlers = {};

/**
 * An AJAX helper. This wraps around jQuery's AJAX function, and dispatches results to the
 * appropriate handler.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 * @constructor
 */
cah.Ajax = function() {
  // TODO run a timer to see if we have more than X pending requests and delay further ones until
  // we get results

  /**
   * Id->data map of active requests. This is so we can map back to the request data when we get a
   * response.
   * 
   * @type {Object}
   * @private
   */
  this.pendingRequests_ = {};
};

$(document).ready(function() {
  /**
   * Singleton instance for ajax utility.
   * 
   * @type {cah.Ajax}
   */
  cah.Ajax.instance = new cah.Ajax();
  $.ajaxSetup({
    cache : false,
    context : cah.Ajax.instance,
    error : cah.Ajax.instance.error,
    success : cah.Ajax.instance.done,
    timeout : cah.DEBUG ? undefined : 10 * 1000, // 10 second timeout for normal requests
    type : 'POST',
    url : cah.AJAX_URI,
  });
});

/**
 * Send an ajax request to the server, and store that the request was sent so we know when it gets
 * responded to. This should be used for data sent to the server, not long-polling.
 * 
 * @param {cah.ajax.Builder}
 *          builder Request builder containing data to use.
 */
cah.Ajax.prototype.requestWithBuilder = function(builder) {
  var jqXHR = $.ajax({
    data : builder.data
  });
  this.pendingRequests_[builder.getSerial()] = builder;
  cah.log.debug("ajax req", builder.data);
  if (builder.errback) {
    jqXHR.fail(builder.errback);
  }
};

/**
 * Handler for when there is a communication-level error with an ajax request. This will likely be
 * because the server isn't responding or returned malformed data.
 * 
 * @param {Object}
 *          jqXHR The jQueryXmlHttpRequest.
 * @param {String}
 *          textStatus Status message.
 * @param {String}
 *          errorThrown Error cause.
 */
cah.Ajax.prototype.error = function(jqXHR, textStatus, errorThrown) {
  // TODO deal with this somehow
  // and figure out which request it was so we can remove it from pending
  debugger;
  cah.log.error(textStatus + " " + errorThrown);
};

/**
 * Handler for when an ajax request is completed sucessfully. Examine the result and dispatch it to
 * the appropriate handler.
 * 
 * @param {Object}
 *          data Data returned from the server.
 */
cah.Ajax.prototype.done = function(data) {
  cah.log.debug("ajax done", data);
  if (data[cah.$.AjaxResponse.ERROR]) {
    // TODO cancel any timers or whatever we may have, and disable interface
    // or probably in individual error handlers as there are some errors that are fine like
    // "you don't have that card" etc.
    var req = this.pendingRequests_[data[cah.$.AjaxResponse.SERIAL]];
    if (req && cah.ajax.ErrorHandlers[req.getOp()]) {
      cah.ajax.ErrorHandlers[req.getOp()](data, req.data);
    } else {
      cah.log.error(cah.$.ErrorCode_msg[data[cah.$.AjaxResponse.ERROR_CODE]]);
    }
  } else {
    var req = this.pendingRequests_[data[cah.$.AjaxResponse.SERIAL]];
    if (req && cah.ajax.SuccessHandlers[req.getOp()]) {
      cah.ajax.SuccessHandlers[req.getOp()](data, req.data);
    } else if (req) {
      cah.log.error("Unhandled response for op " + req.getOp());
    } else {
      cah.log.error("Response for unknown serial " + data[cah.$.AjaxResponse.SERIAL]);
    }
  }

  var serial = data[cah.$.AjaxResponse.SERIAL];
  if (serial >= 0 && this.pendingRequests_[serial]) {
    delete this.pendingRequests_[serial];
  }
};

/**
 * Get a builder for an ajax request.
 * 
 * @param {string}
 *          op Operation code for the request.
 * @returns {cah.ajax.Builder} Builder to create the request.
 */
cah.Ajax.build = function(op) {
  return new cah.ajax.Builder(op);
};
