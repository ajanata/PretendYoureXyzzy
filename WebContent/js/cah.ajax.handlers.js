/**
 * AJAX callback handlers. TODO make this individual files instead of all in one.
 * 
 * @author ajanata
 */

cah.ajax.SuccessHandlers.register = function(data) {
  cah.nickname = data['nickname'];
  cah.log.status("You are connected as " + cah.nickname);
  $("#nickbox").hide();
  $("#canvass").show();

  cah.ajax.after_registered();
};

cah.ajax.ErrorHandlers.register = function(data) {
  $("#nickbox_error").text(data.error_message);
  $("#nickname").focus();
};

cah.ajax.SuccessHandlers.firstload = function(data) {
  if (data.in_progress) {
    // TODO reload data. see what 'next' is and go from there.
    // for now just load the nickname
    cah.nickname = data['nickname'];
    cah.log.status("You have reconnected as " + cah.nickname);
    $("#nickbox").hide();
    $("#canvass").show();
    cah.ajax.after_registered();
  }
};

cah.ajax.ErrorHandlers.firstload = function(data) {
  // TODO dunno what to do here, if anything
};

/**
 * This should only be called after we have a valid registration with the server, as we start doing
 * long polling here.
 */
cah.ajax.after_registered = function() {
  cah.log.debug("done registering");
  cah.longpoll.longPoll();
};

cah.ajax.SuccessHandlers.chat = function(data) {
  // pass
};
