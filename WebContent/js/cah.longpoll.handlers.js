/*
 * Copyright (c) 2012, Andy Janata All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 *  * Redistributions of source code must retain the above copyright notice, this list of conditions
 * and the following disclaimer. * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the documentation and/or other
 * materials provided with the distribution.
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
 * Event handlers from long-poll operations.
 * 
 * TODO possibly split this into multiple files.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */

cah.longpoll.ErrorCodeHandlers[cah.$.ErrorCode.NOT_REGISTERED] = function(data) {
  cah.longpoll.Resume = false;
  cah.log.error("The server seems to have restarted. Any in-progress games have been lost.");
  cah.log.error("You will need to refresh the page to start a new game.");
  $("input").attr("disabled", "disabled");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.NEW_PLAYER] = function(data) {
  // don't display our own join
  if (data[cah.$.LongPollResponse.NICKNAME] != cah.nickname) {
    cah.log.status(data[cah.$.LongPollResponse.NICKNAME] + " has connected.");
  }
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.PLAYER_LEAVE] = function(data) {
  var friendly_reason = "Leaving";
  switch (data[cah.$.LongPollResponse.REASON]) {
    case cah.$.DisconnectReason.KICKED:
      friendly_reason = "Kicked by server";
      break;
    case cah.$.DisconnectReason.MANUAL:
      friendly_reason = "Leaving";
      break;
    case cah.$.DisconnectReason.PING_TIMEOUT:
      friendly_reason = "Ping timeout";
      break;
  }
  cah.log.status(data[cah.$.LongPollResponse.NICKNAME] + " has disconnected (" + friendly_reason
      + ").");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.NOOP] = function(data) {
  // pass
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.KICKED] = function() {
  cah.log.status("You have been kicked by the server administrator.");
  cah.longpoll.Resume = false;
  $("input").attr("disabled", "disabled");
  $("#menubar_left").empty();
  $("#main").empty();
  $("#info_area").empty();
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.CHAT] = function(data) {
  // TODO deal with multiple channels eventually
  // don't display our own chat
  if (data[cah.$.LongPollResponse.FROM] != cah.nickname) {
    cah.log.status("<" + data[cah.$.LongPollResponse.FROM] + "> "
        + data[cah.$.LongPollResponse.MESSAGE]);
  }
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_LIST_REFRESH] = function(data) {
  cah.GameList.instance.update();
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_PLAYER_JOIN] = function(data) {
  cah.longpoll.EventHandlers.__gameEvent(data, cah.Game.prototype.playerJoin,
      data[cah.$.LongPollResponse.NICKNAME],
      "player join (if you just joined a game this may be OK)");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_PLAYER_LEAVE] = function(data) {
  cah.longpoll.EventHandlers.__gameEvent(data, cah.Game.prototype.playerLeave,
      data[cah.$.LongPollResponse.NICKNAME], "player leave");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.HAND_DEAL] = function(data) {
  cah.longpoll.EventHandlers.__gameEvent(data, cah.Game.prototype.dealtCards,
      data[cah.$.LongPollResponse.HAND], "dealt cards");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_STATE_CHANGE] = function(data) {
  cah.longpoll.EventHandlers
      .__gameEvent(data, cah.Game.prototype.stateChange, data, "state change");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_PLAYER_INFO_CHANGE] = function(data) {
  cah.longpoll.EventHandlers.__gameEvent(data, cah.Game.prototype.updateUserStatus,
      data[cah.$.LongPollResponse.PLAYER_INFO], "player info change");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_ROUND_COMPLETE] = function(data) {
  cah.longpoll.EventHandlers.__gameEvent(data, cah.Game.prototype.roundComplete, data,
      "round complete");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_WHITE_RESHUFFLE] = function(data) {
  cah.longpoll.EventHandlers.__gameEvent(data, cah.Game.prototype.reshuffle, "white",
      "white reshuffle");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_BLACK_RESHUFFLE] = function(data) {
  cah.longpoll.EventHandlers.__gameEvent(data, cah.Game.prototype.reshuffle, "black",
      "black reshuffle");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_JUDGE_LEFT] = function(data) {
  cah.longpoll.EventHandlers.__gameEvent(data, cah.Game.prototype.judgeLeft, "", "judge left");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_OPTIONS_CHANGED] = function(data) {
  cah.longpoll.EventHandlers.__gameEvent(data, cah.Game.prototype.optionsChanged, data,
      "options changed");
};

/**
 * Helper for event handlers for game events.
 * 
 * @param {Object}
 *          data Data from server
 * @param {Function}
 *          func Function to call.
 * @param {Object}
 *          funcData Data to be passed to the function.
 * @param {String}
 *          errorStr To be displayed if this is for an unknown game.
 */
cah.longpoll.EventHandlers.__gameEvent = function(data, func, funcData, errorStr) {
  var gameId = data[cah.$.LongPollResponse.GAME_ID];
  var game = cah.currentGames[gameId];
  if (game) {
    func.call(game, funcData);
  } else {
    cah.log.error("Received " + errorStr + " for unknown game id " + gameId);
  }
};
