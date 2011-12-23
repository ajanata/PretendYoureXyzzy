/**
 * Main app for cah.
 * 
 * @author ajanata
 */

$(document).ready(function() {
  // TODO see if we have a stored nickname somewhere
  $("#nicknameconfirm").click(nicknameconfirm_click);
  $("#nickbox").keyup(nickbox_keyup);
  $("#nickbox").focus();
});

function nickbox_keyup(e) {
  if (e.which == 13) {
    $("#nicknameconfirm").click();
    e.preventDefault();
  }
}

function nicknameconfirm_click(e) {
  nickname = $.trim($("#nickname").val());
  cah.ajax.request("register", {
    nickname : nickname
  });
}
