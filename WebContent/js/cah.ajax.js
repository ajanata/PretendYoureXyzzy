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
 * Create a new cah ajax helper.
 * 
 * @returns {cah.ajax.lib}
 * @constructor
 */
cah.Ajax = function() {
  // TODO run a timer to see if we have more than X pending requests and delay further ones until
  // we get results
  this.pendingRequests = {};
};

$(document).ready(function() {
  /**
   * Singleton instance for ajax utility.
   * 
   * @type {cah.ajax.lib}
   */
  cah.Ajax.instance = new cah.Ajax();
  $.ajaxSetup({
    cache : false,
    context : cah.Ajax.instance,
    error : cah.Ajax.instance.error,
    success : cah.Ajax.instance.done,
    timeout : cah.DEBUG ? undefined : 10 * 1000, // 10 second timeout for normal requests
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
 * @param {cah.ajax.Builder}
 *          builder Request builder containing data to use.
 */
cah.Ajax.prototype.requestWithBuilder = function(builder) {
  var jqXHR = $.ajax({
    data : builder.data
  });
  this.pendingRequests[builder.data.serial] = builder.data;
  cah.log.debug("ajax req", builder.data);
  if (builder.errback) {
    jqXHR.fail(builder.errback);
  }
};

cah.Ajax.prototype.error = function(jqXHR, textStatus, errorThrown) {
  // TODO deal with this somehow
  // and figure out which request it was so we can remove it from pending
  debugger;
  cah.log.error(textStatus);
};

cah.Ajax.prototype.done = function(data) {
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
