/**
 * Main app for cah.
 * 
 * @author ajanata
 */

$(document).ready(function() {
  // see if we already exist on the server so we can resume
  cah.Ajax.request("firstload", {});

  // TODO see if we have a stored nickname somewhere
  $("#nicknameconfirm").click(nicknameconfirm_click);
  $("#nickbox").keyup(nickbox_keyup);
  $("#nickbox").focus();

  $("#chat").keyup(chat_keyup);
  $("#chat_submit").click(chatsubmit_click);
});

function nickbox_keyup(e) {
  if (e.which == 13) {
    $("#nicknameconfirm").click();
    e.preventDefault();
  }
}

function nicknameconfirm_click(e) {
  var nickname = $.trim($("#nickname").val());
  cah.Ajax.request("register", {
    nickname : nickname,
  });
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
  cah.Ajax.request("chat", {
    message : text,
  });
  cah.log.status("&lt;" + cah.nickname + "&gt; " + text);
  $("#chat").val("");
  $("#chat").focus();
}
