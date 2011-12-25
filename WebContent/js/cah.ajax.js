/**
 * AJAX utility functions for cah. Core library. Individual handlers should be elsewhere.
 * 
 * @author ajanata
 */

cah.ajax = {};
cah.ajax.ErrorHandlers = {};
cah.ajax.SuccessHandlers = {};

/**
 * Create a new cah ajax helper.
 * 
 * @returns {cah.ajax.lib}
 * @constructor
 */
cah.ajax.lib = function() {
  // TODO run a timer to see if we have more than X pending requests and delay further ones until
  // we get results
  this.pendingRequests = {};
  this.serial = 0;
};

$(document).ready(function() {
  /**
   * Singleton instance for ajax utility.
   * 
   * @type {cah.ajax.lib}
   */
  cah.Ajax = new cah.ajax.lib();
  $.ajaxSetup({
    cache : false,
    context : cah.Ajax,
    error : cah.Ajax.error,
    success : cah.Ajax.done,
    timeout : cah.DEBUG ? undefined : 10 * 1000, // 10 second timeout for normal requests
    // timeout : 1, // 10 second timeout for normal requests
    type : 'POST',
    url : '/cah/AjaxServlet'
  });
});

/**
 * Send an ajax request to the server, and store that the request was sent so we know when it gets
 * responded to.
 * 
 * This should be used for data sent to the server, not long-polling.
 * 
 * @param {string}
 *          op Operation code for the request.
 * @param {object}
 *          data Parameter map to send for the request.
 * @param {?function(jqXHR,textStatus,errorThrown)}
 *          [opt_errback] Optional error callback.
 */
cah.ajax.lib.prototype.request = function(op, data, opt_errback) {
  data.op = op;
  data.serial = this.serial++;
  var jqXHR = $.ajax({
    data : data
  });
  this.pendingRequests[data.serial] = data;
  cah.log.debug("ajax req", data);
  if (opt_errback) {
    jqXHR.fail(opt_errback);
  }
};

cah.ajax.lib.prototype.error = function(jqXHR, textStatus, errorThrown) {
  // TODO deal with this somehow
  // and figure out which request it was so we can remove it from pending
  debugger;
  cah.log.error(textStatus);
};

cah.ajax.lib.prototype.done = function(data) {
  cah.log.debug("ajax done", data);
  if (data['error']) {
    // TODO cancel any timers or whatever we may have, and disable interface
    var req = this.pendingRequests[data.serial];
    if (req && cah.ajax.ErrorHandlers[req.op]) {
      cah.ajax.ErrorHandlers[req.op](data);
    } else {
      cah.log.error(data.error_message);
    }
  } else {
    var req = this.pendingRequests[data.serial];
    if (req && cah.ajax.SuccessHandlers[req.op]) {
      cah.ajax.SuccessHandlers[req.op](data);
    } else if (req) {
      cah.log.error("Unhandled response for op " + req.op);
    } else {
      cah.log.error("Response for unknown serial " + data.serial);
    }
  }

  if (data.serial >= 0 && this.pendingRequests[data.serial]) {
    delete this.pendingRequests[data.serial];
  }
};
