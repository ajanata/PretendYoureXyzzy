/**
 * Main app for cah.
 * 
 * @author ajanata
 */

$(document).ready(function() {
  // see if we already exist on the server so we can resume
  cah.Ajax.build(cah.$.AjaxOperation.FIRST_LOAD).run();

  // TODO see if we have a stored nickname somewhere
  $("#nicknameconfirm").click(nicknameconfirm_click);
  $("#nickbox").keyup(nickbox_keyup);
  $("#nickbox").focus();

  $("#chat").keyup(chat_keyup);
  $("#chat_submit").click(chatsubmit_click);

  // TODO: have some sort of mechanism to alert the server that we have unloaded the page, but
  // have not expressed an interest in being cleared out yet.
  // $(window).bind("beforeunload", window_beforeunload);
  $("#logout").click(logout_click);
});

function nickbox_keyup(e) {
  if (e.which == 13) {
    $("#nicknameconfirm").click();
    e.preventDefault();
  }
}

function nicknameconfirm_click(e) {
  var nickname = $.trim($("#nickname").val());
  cah.Ajax.build(cah.$.AjaxOperation.REGISTER).withNickname(nickname).run();
}

function chat_keyup(e) {
  if (e.which == 13) {
    $("#chat_submit").click();
    e.preventDefault();
  }
}

function chatsubmit_click(e) {
  var text = $.trim($("#chat").val());
  // TODO when I get multiple channels working, this needs to know active and pass it
  cah.Ajax.build(cah.$.AjaxOperation.CHAT).withMessage(text).run();
  cah.log.status("&lt;" + cah.nickname + "&gt; " + text);
  $("#chat").val("");
  $("#chat").focus();
}

function logout_click(e) {
  cah.Ajax.build(cah.$.AjaxOperation.LOG_OUT).run();
}
