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
  this.pendingRequests[builder.getSerial()] = builder;
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
  if (data[cah.$.AjaxResponse.ERROR]) {
    // TODO cancel any timers or whatever we may have, and disable interface
    var req = this.pendingRequests[data[cah.$.AjaxResponse.SERIAL]];
    if (req && cah.ajax.ErrorHandlers[req.getOp()]) {
      cah.ajax.ErrorHandlers[req.getOp()](data);
    } else {
      cah.log.error(cah.$.ErrorCode_msg[data[cah.$.AjaxResponse.ERROR_CODE]]);
    }
  } else {
    var req = this.pendingRequests[data[cah.$.AjaxResponse.SERIAL]];
    if (req && cah.ajax.SuccessHandlers[req.getOp()]) {
      cah.ajax.SuccessHandlers[req.getOp()](data);
    } else if (req) {
      cah.log.error("Unhandled response for op " + req.getOp());
    } else {
      cah.log.error("Response for unknown serial " + data[cah.$.AjaxResponse.SERIAL]);
    }
  }

  var serial = data[cah.$.AjaxResponse.SERIAL];
  if (serial >= 0 && this.pendingRequests[serial]) {
    delete this.pendingRequests[serial];
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
