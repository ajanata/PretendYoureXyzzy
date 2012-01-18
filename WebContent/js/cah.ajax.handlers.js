/**
 * AJAX callback handlers.
 * 
 * TODO make this individual files instead of all in one.
 * 
 * @author ajanata
 */

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.REGISTER] = function(data) {
  cah.nickname = data['nickname'];
  cah.log.status("You are connected as " + cah.nickname);
  $("#nickbox").hide();
  $("#canvass").show();

  cah.ajax.after_registered();
};

cah.ajax.ErrorHandlers[cah.$.AjaxOperation.REGISTER] = function(data) {
  $("#nickbox_error").text(cah.$.ErrorCode_msg[data.error_code]);
  $("#nickname").focus();
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.FIRST_LOAD] = function(data) {
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

cah.ajax.ErrorHandlers[cah.$.AjaxOperation.FIRST_LOAD] = function(data) {
  // TODO dunno what to do here, if anything
};

/**
 * This should only be called after we have a valid registration with the server, as we start doing
 * long polling here.
 */
cah.ajax.after_registered = function() {
  cah.log.debug("done registering");
  // TODO once there are channels, this needs to specify the global channel
  cah.Ajax.build(cah.$.AjaxOperation.NAMES).run();
  cah.Ajax.build(cah.$.AjaxOperation.GAME_LIST).run();
  cah.longpoll.longPoll();
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.CHAT] = function(data) {
  // pass
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.LOG_OUT] = function(data) {
  window.location.reload();
};

cah.ajax.ErrorHandlers[cah.$.AjaxOperation.LOG_OUT] = cah.ajax.SuccessHandlers.logout;

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.NAMES] = function(data) {
  cah.log.status("Currently connected: " + data.names.join(", "));
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.GAME_LIST] = function(data) {
  cah.GameList.instance.update(data);
};
