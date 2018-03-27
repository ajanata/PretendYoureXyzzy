/*
 * Copyright (c) 2012-2018, Andy Janata
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
 * Logging functions.
 * 
 * TODO make this a proper object with a singleton instance.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */

cah.log = {};

/**
 * "Global Chat" tab's chat log
 */
cah.log.init = function() {
  cah.log.log = $('#tab-global .log');
};

/**
 * Log a message to the global chat window for the user the see, always, as a status message. This
 * is also used for chat. The current time is displayed with the log message, using the user's
 * locale settings to determine format.
 * 
 * @param {string}
 *          text Text to display for this message. Text is added as a TextNode, so HTML is properly
 *          escaped automatically.
 * @param {string}
 *          opt_class Optional CSS class to use for this message.
 * @param {boolean}
 *          opt_allow_html Allow HTML to be used.
 * @param {string}
 *          opt_title Optional title text for span.
 */
cah.log.status = function(text, opt_class, opt_allow_html, opt_title) {
  cah.log.status_with_game(null, text, opt_class, opt_allow_html, opt_title);
};

/**
 * Log a message to a single game's chat window, or the global chat window if game_id is null. This
 * is also used to support chat.
 * 
 * This displays the current time with the log message, using the user's locale settings to
 * determine format.
 * 
 * @param {Number|cah.Game}
 *          game_or_id ID of the game for which this message should be displayed, or the game object
 *          itself, or null for the global chat window.
 * @param {string}
 *          text Text to display for this message. Text is added as a TextNode, so HTML is properly
 *          escaped automatically.
 * @param {string}
 *          opt_class Optional CSS class to use for this message.
 * @param {boolean}
 *          opt_allow_html Allow HTML to be used.
 * @param {string}
 *          opt_title Optional title text for span.
 */
cah.log.status_with_game = function(game_or_id, text, opt_class, opt_allow_html, opt_title) {
  var logElement;
  // I think == null here would catch both of these cases and also be okay with game id 0 but...
  if (game_or_id === null || game_or_id === undefined) {
    logElement = cah.log.log;
  } else {
    var game;
    if (game_or_id instanceof cah.Game) {
      game = game_or_id;
    } else {
      game = cah.currentGames[game_or_id];
    }
    logElement = $(".log", game.getChatElement());
  }

  // TODO this doesn't work right on some mobile browsers
  var scroll = (logElement.prop("scrollHeight") - logElement.height() - logElement
      .prop("scrollTop")) <= 5;

  var node;
  if (opt_title) {
    node = $("<span title ='" + opt_title + "'></span><br/>");
  } else {
    node = $("<span></span><br/>");
  }
  var full_msg = "[" + new Date().toLocaleTimeString() + "] " + text + "\n";
  if (opt_allow_html) {
    $(node[0]).html(full_msg);
  } else {
    $(node[0]).text(full_msg);
  }
  if (opt_class) {
    $(node).addClass(opt_class);
  }
  logElement.append(node);
  // only announce things in our game, or if it has a class (admin or error, likely)
  if (game_or_id !== null || opt_class) {
    cah.log.ariaStatus(text);
  }

  if (scroll) {
    logElement.prop("scrollTop", logElement.prop("scrollHeight"));
  }
};

/**
 * Log a message for the user to see, always, in every tab, as an error message.
 * 
 * @param {string}
 *          text Text to display for this message. Text is added as a TextNode, so HTML is properly
 *          escaped automatically.
 */
cah.log.error = function(text) {
  cah.log.everyWindow("Error: " + text, "error");
};

/**
 * Log a message for the user to see, always, in every tab.
 * 
 * @param {string}
 *          text Text to display for this message. Text is added as a TextNode, so HTML is properly
 *          escaped automatically.
 * @param {string}
 *          opt_class Optional CSS class to use for this message.
 */
cah.log.everyWindow = function(text, opt_class) {
  cah.log.status(text, opt_class);

  for (game_id in cah.currentGames) {
    if (cah.currentGames.hasOwnProperty(game_id)) {
      cah.log.status_with_game(game_id, text, opt_class);
    }
  }
};

/**
 * Set the text of the aria-notification element, which should cause screen readers to read this
 * text.
 * 
 * @param {string}
 *          text Text to read.
 */
cah.log.ariaStatus = function(text) {
  // TODO we should pull this regex from the java code. it's close enough for now
  var chatMatch = text.match(/<([a-zA-Z0-9_]+)> (.*)/);
  if (chatMatch) {
    $('#aria-notifications').text(chatMatch[1] + ' says ' + chatMatch[2]);
  } else {
    $('#aria-notifications').text(text);
  }
};

/**
 * Log a message if debugging is enabled, optionally dumping the contents of an object.
 * 
 * If SILENT_DEBUG is on, and IE is in use, it can cause the game to break if the debugger isn't
 * open...
 * 
 * @param {string}
 *          text Text to display
 * @param {object}
 *          opt_obj Optional. Object to dump along with message.
 */
cah.log.debug = function(text, opt_obj) {
  if (cah.SILENT_DEBUG && console) {
    if (console.debug) {
      console.debug("[" + new Date().toLocaleTimeString() + "]", text, opt_obj);
    } else if (console.log) {
      console.log("[" + new Date().toLocaleTimeString() + "] " + text);
      if (opt_obj) {
        if (console.dir) {
          console.dir(opt_obj);
        } else if (JSON && JSON.stringify) {
          console.log(JSON.stringify(opt_obj));
        } else {
          console.log("TODO: SILENT_DEBUG without console.debug, with console.log, "
              + "without console.dir, without JSON.stringify");
        }
      }
    } else if (console.log) {
      console.log("[" + new Date().toLocaleTimeString() + "]", text, opt_obj);
    }
  }
  if (cah.DEBUG) {
    if (opt_obj) {
      if (JSON && JSON.stringify) {
        cah.log.debug(text + ": " + JSON.stringify(opt_obj));
      } else {
        cah.log.debug(text + ": TODO: debug log without JSON.stringify()");
      }
    } else {
      cah.log.status("DEBUG: " + text, "debug");
    }
  }
};

/**
 * Get the title text to use for the given idcode, or a null if there is no idcode.
 * 
 * @param {string}
 *          idcode ID code, or logical false to not have a title.
 */
cah.log.getTitleForIdCode = function(idcode) {
  if (idcode) {
    return "Verification code: " + idcode;
  } else {
    return null;
  }
};
