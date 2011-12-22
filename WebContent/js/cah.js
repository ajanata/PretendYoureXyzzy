var cah = {};
cah.ajax = {};
cah.ajax.ErrorHandlers = {};
cah.ajax.SuccessHandlers = {};

cah.DEBUG = true;
cah.LONG_POLL_TIMEOUT = 2 * 60 * 1000;

cah.ajax.ErrorHandlers.register = ajax_register_error;
cah.ajax.ErrorHandlers.firstload = ajax_firstload_error;

cah.ajax.SuccessHandlers.register = ajax_register_success;
cah.ajax.SuccessHandlers.firstload = ajax_firstload_success;

var nickname;
var serial = 0;
// TODO run a timer to see if we have more than X pending requests and delay further ones until
// we get results
var pendingRequests = {};

$(document).ready(function() {
  $.ajaxSetup({
    cache : false,
    error : ajaxError,
    success : ajaxDone,
    timeout : cah.DEBUG ? undefined : 10 * 1000, // 10 second timeout for normal requests
    // timeout : 1, // 10 second timeout for normal requests
    type : 'POST',
    url : '/cah/AjaxServlet'
  });

  ajaxRequest("firstload", {});

  // TODO see if we have a stored nickname somewhere
  $("#nicknameconfirm").click(nicknameconfirm_click);
  $("#nickbox").keyup(nickbox_keyup);

});

function nickbox_keyup(e) {
  if (e.which == 13) {
    $("#nicknameconfirm").click();
    e.preventDefault();
  }
}

function nicknameconfirm_click(e) {
  nickname = $.trim($("#nickname").val());
  ajaxRequest("register", {
    nickname : nickname
  });
}

function addLog(text) {
  $("#log").append("[" + new Date().toLocaleTimeString() + "] " + text + "<br/>");
  $("#log").prop("scrollTop", $("#log").prop("scrollHeight"));
}

function addLogError(text) {
  addLog("<span class='error'>Error: " + text + "</span>");
}

function addLogDebug(text) {
  if (cah.DEBUG) {
    addLog("<span class='debug'>DEBUG: " + text + "</span>");
  }
}

function addLogDebugObject(text, obj) {
  if (cah.DEBUG) {
    if (JSON && JSON.stringify) {
      addLogDebug(text + ": " + JSON.stringify(obj));
    } else {
      addLogDebug(text + ": TODO: debug log without JSON.stringify()");
    }
  }
}

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
function ajaxRequest(op, data, opt_errback) {
  data.op = op;
  data.serial = serial++;
  var jqXHR = $.ajax({
    data : data
  });
  pendingRequests[data.serial] = data;
  addLogDebugObject("ajax req", data);
  if (opt_errback) {
    jqXHR.fail(opt_errback);
  }
}

function ajaxError(jqXHR, textStatus, errorThrown) {
  // TODO deal with this somehow
  // and figure out which request it was so we can remove it from pending
  debugger;
  addLogError(textStatus);
}

function ajaxDone(data) {
  addLogDebugObject("ajax done", data);
  if (data['error']) {
    // TODO cancel any timers or whatever we may have, and disable interface
    var req = pendingRequests[data.serial];
    if (req && cah.ajax.ErrorHandlers[req.op]) {
      cah.ajax.ErrorHandlers[req.op](data);
    } else {
      addLogError(data.error_message);
    }
  } else {
    var req = pendingRequests[data.serial];
    if (req && cah.ajax.SuccessHandlers[req.op]) {
      cah.ajax.SuccessHandlers[req.op](data);
    } else if (req) {
      addLogError("Unhandled response for op " + req.op);
    } else {
      addLogError("Unknown response for serial " + data.serial);
    }
  }

  if (data.serial >= 0 && pendingRequests[data.serial]) {
    delete pendingRequests[data.serial];
  }
}

function ajax_register_success(data) {
  nickname = data['nickname'];
  addLog("You are connected as " + nickname);
  $("#nickbox").hide();
  $("#canvass").show();

  after_registered();
}

function ajax_register_error(data) {
  $("#nickbox").append("<span class='error'>" + data.error_message + "</span>");
  $("#nickname").focus();
}

function ajax_firstload_success(data) {
  if (data.in_progress) {
    // TODO reload data. see what 'next' is and go from there.
    // for now just load the nickname
    nickname = data['nickname'];
    addLog("You have reconnected as " + nickname);
    $("#nickbox").hide();
    $("#canvass").show();
    after_registered();
  }
}

function ajax_firstload_error(data) {
  // TODO dunno what to do here
}

/**
 * This should only be called after we have a valid registration with the server, as we start doing
 * long polling here.
 */
function after_registered() {
  addLogDebug("done registering");
  long_poll();
}

function long_poll() {
  addLogDebug("starting long poll");
  $.ajax({
    complete : long_poll,
    error : long_poll_error,
    success : long_poll_done,
    timeout : cah.LONG_POLL_TIMEOUT,
    url : '/cah/LongPollServlet',
  });
}

function long_poll_done(data) {
  addLogDebugObject("long poll done", data);
}

function long_poll_error(jqXHR, textStatus, errorThrown) {
  // TODO deal with this somehow
  debugger;
  addLogError(textStatus);
}
