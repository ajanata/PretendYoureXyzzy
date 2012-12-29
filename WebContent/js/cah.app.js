/*
 * Copyright (c) 2012, Andy Janata
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * 
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 *   and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 *   conditions and the following disclaimer in the documentation and/or other materials provided
 *   with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * Main application for Pretend You're Xyzzy. This only has to handle the initial nickname
 * registration, the chat box, the logout button, and resizing the window. It should probably be
 * split up into multiple files.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */

$(document).ready(function() {
  // Initialize the logger (i.e. the global chat tab) before anything needs it.
  cah.log.init();

  // see if we already exist on the server so we can resume
  cah.Ajax.build(cah.$.AjaxOperation.FIRST_LOAD).run();

  if ($.cookie("nickname")) {
    $("#nickname").val($.cookie("nickname"));
  }
  $("#nicknameconfirm").click(nicknameconfirm_click);
  $("#nickbox").keyup(nickbox_keyup);
  $("#nickbox").focus();

  $(".chat", $("#tab-global")).keyup(chat_keyup);
  $(".chat_submit", $("#tab-global")).click(chatsubmit_click());

  // TODO: have some sort of mechanism to alert the server that we have unloaded the page, but
  // have not expressed an interest in being cleared out yet.
  // $(window).bind("beforeunload", window_beforeunload);
  $("#logout").click(logout_click);

  load_preferences();

  $("#tabs").tabs();
  $("#button-global").click();

  if ($.browser.mozilla) {
    // Firefox sucks.
    $("body").css("font-size", "12px");
  }

  $(window).resize(app_resize);
  app_resize();
});

/**
 * Handle a key up event in the nick box. If the key was enter, try to register with the server.
 * 
 * @param {jQuery.Event}
 *          e
 */
function nickbox_keyup(e) {
  if (e.which == 13) {
    $("#nicknameconfirm").click();
    e.preventDefault();
  }
}

/**
 * Handle a click event on the set nickname box. Try to register with the server.
 */
function nicknameconfirm_click() {
  var nickname = $.trim($("#nickname").val());
  $.cookie("nickname", nickname, {
    expires : 365
  });
  cah.Ajax.build(cah.$.AjaxOperation.REGISTER).withNickname(nickname).run();
}

/**
 * Handle a key up event in the chat box. If the key was enter, send the message to the server.
 * 
 * @param {jQuery.Event}
 *          e
 */
function chat_keyup(e) {
  if (e.which == 13) {
    $(".chat_submit", $('#tab-global')).click();
    e.preventDefault();
  }
}

/**
 * Generate a click handler for the chat submit button.  This parses the line
 * for any /-commands, then sends the request to the server.
 */
function chatsubmit_click() {
  return function() {
    var text = $.trim($(".chat", $("#tab-global")).val());
    if (text == "") {
      return;
    }
    var cmd = '';
    if ('/' == text.substring(0, 1)) {
      cmd = text.substring(1, text.indexOf(' ') >= 0 ? text.indexOf(' ') : undefined);
      if (text.indexOf(' ') >= 0) {
        text = text.substring(text.indexOf(' ') + 1);
      } else {
        text = '';
      }
    }
    switch (cmd) {
      // TODO support an /ignore command
      case '':
        // TODO when I get multiple channels working, this needs to know active and pass it
        cah.Ajax.build(cah.$.AjaxOperation.CHAT).withMessage(text).withGameId(cah.Game.id_).run();
        cah.log.status("<" + cah.nickname + "> " + text);
        break;
      case 'kick':
        cah.Ajax.build(cah.$.AjaxOperation.KICK).withNickname(text.split(' ')[0]).run();
        break;
      case 'ban':
        // this could also be an IP address
        cah.Ajax.build(cah.$.AjaxOperation.BAN).withNickname(text.split(' ')[0]).run();
        break;
      case 'names':
        cah.Ajax.build(cah.$.AjaxOperation.NAMES).run();
        break;
      default:
    }

    $(".chat", $("#tab-global")).val("");
    $(".chat", $("#tab-global")).focus();
  };
}

/**
 * Handle a click event on the log out button. Tell the server to log us out.
 */
function logout_click() {
  if (confirm("Are you sure you wish to log out?")) {
    cah.Ajax.build(cah.$.AjaxOperation.LOG_OUT).run();
  }
}

/**
 * Handle a click event on the preferences button. Shows the preferences modal dialog.
 */
function preferences_click() {
  $("#preferences_dialog").dialog({
    modal : true,
    buttons : {
      Ok : function() {
        save_preferences();
        $(this).dialog("close");
      }
    }
  });
}

function load_preferences() {
  if ($.cookie("hide_connect_quit")) {
    $("#hide_connect_quit").attr('checked', 'checked');
  } else {
    $("#hide_connect_quit").removeAttr('checked');
  }

  if ($.cookie("ignore_list")) {
    $("#ignore_list").val($.cookie("ignore_list"));
  } else {
    $("#ignore_list").val("");
  }

  apply_preferences();
}

function save_preferences() {
  if ($("#hide_connect_quit").attr("checked")) {
    $.cookie("hide_connect_quit", true, {
      expires : 365
    });
  } else {
    $.removeCookie("hide_connect_quit");
  }

  $.cookie("ignore_list", $("#ignore_list").val(), {
    expires : 365
  });

  apply_preferences();
}

function apply_preferences() {
  cah.hideConnectQuit = !!$("#hide_connect_quit").attr("checked");

  cah.ignoreList = {};
  $($('#ignore_list').val().split('\n')).each(function() {
    cah.ignoreList[this] = true;
  });
}

/**
 * Handle a window resize event. Resize the chat and info areas to fit vertically and horizontally.
 * This was tested extensively in Chrome. It may not be pixel-perfect in other browsers.
 */
function app_resize() {
  var chat = $(".chat", $("#tab-global"));
  var log = cah.log.log;

  var chatWidth = $("#canvas").width() - 257;
  $("#tabs").width(chatWidth + 'px');
  log.width((chatWidth + 2) + 'px');
  chat.width((chatWidth - 42) + 'px');
  var bottomHeight = $(window).height() - $("#main").height() - $("#menubar").height() - 29;
  $("#bottom").height(bottomHeight);
  $("#info_area").height(bottomHeight);
  $("#tabs").height(bottomHeight);
  log.height(bottomHeight - chat.height() - 40);
  // this is ugly and terrible.
  if ($(window).height() < 650) {
    $("body").css("overflow-y", "auto");
  } else {
    $("body").css("overflow-y", "hidden");
  }
}
