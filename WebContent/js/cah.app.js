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

  // if (($.browser.mozilla || $.browser.opera) && !$.cookie("browser_dismiss")) {
  // var name = $.browser.mozilla ? "Firefox" : "Opera";
  // $("#browser").show();
  // $("#browser_name").text(name);
  // $("#browser_ok").click(function() {
  // $("#browser").hide();
  // $.cookie("browser_dismiss", true, {
  // expires : 3650,
  // });
  // });
  // }

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
    $("#chat_submit").click();
    e.preventDefault();
  }
}

/**
 * Handle a click even on the chat button. Send the message to the server.
 */
function chatsubmit_click() {
  var text = $.trim($("#chat").val());
  if (text == "") {
    return;
  }
  // TODO when I get multiple channels working, this needs to know active and pass it
  cah.Ajax.build(cah.$.AjaxOperation.CHAT).withMessage(text).run();
  cah.log.status("<" + cah.nickname + "> " + text);
  $("#chat").val("");
  $("#chat").focus();
}

/**
 * Handle a click event on the log out button. Tell the server to log us out.
 */
function logout_click() {
  cah.Ajax.build(cah.$.AjaxOperation.LOG_OUT).run();
}

/**
 * Handle a window resize event. Resize the chat and info areas to fit vertically and horizontally.
 * This was tested extensively in Chrome. It may not be pixel-perfect in other browsers.
 */
function app_resize() {
  var chatWidth = $("#canvas").width() - 251;
  $("#chat_area").width(chatWidth);
  $("#chat").width(chatWidth - 48);
  var bottomHeight = $(window).height() - $("#main").height() - $("#menubar").height() - 27;
  $("#bottom").height(bottomHeight);
  $("#info_area").height(bottomHeight);
  $("#chat_area").height(bottomHeight);
  $("#log").height(bottomHeight - $("#chat").height() - 1);
  // this is ugly and terrible.
  if ($(window).height() < 650) {
    $("body").css("overflow-y", "auto");
  } else {
    $("body").css("overflow-y", "hidden");
  }
}
