var cah = {};
cah.ajax = {};
cah.ajax.ErrorHandlers = {};
cah.ajax.SuccessHandlers = {};

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

/**
 * Send an ajax request to the server, and store that the request was sent so we know when it gets
 * responded to.
 * 
 * @param op
 *          {string} Operation code for the request.
 * @param data
 *          {object} Parameter map to send for the request.
 */
function ajaxRequest(op, data) {
  data.op = op;
  data.serial = serial++;
  $.ajax({
    data : data
  });
  pendingRequests[data.serial] = data;
}

function ajaxError(jqXHR, textStatus, errorThrown) {
  // TODO deal with this somehow
  // and figure out which request it was so we can remove it from pending
  addLog("<span class='error'>Error: " + textStatus + "</span>");
}

function ajaxDone(data) {
  if (data['error']) {
    // TODO cancel any timers or whatever we may have, and disable interface
    var req = pendingRequests[data.serial];
    if (req && cah.ajax.ErrorHandlers[req.op]) {
      cah.ajax.ErrorHandlers[req.op](data);
    } else {
      addLog("<span class='error'>Error: " + data.error_message + "</span>");
    }
  } else {
    var req = pendingRequests[data.serial];
    if (req && cah.ajax.SuccessHandlers[req.op]) {
      cah.ajax.SuccessHandlers[req.op](data);
    } else if (req) {
      addLog("<span class='error'>Error: Unhandled response for op " + req.op + "</span>");
    } else {
      addLog("<span class='error'>Error: Unknown response for serial " + data.serial + "</span>");
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
  }
}

function ajax_firstload_error(data) {

}
