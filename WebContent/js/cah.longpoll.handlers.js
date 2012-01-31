/**
 * Event handlers from long-poll operations.
 * 
 * @author ajanata
 */

cah.longpoll.ErrorCodeHandlers.not_registered = function(data) {
  cah.longpoll.Resume = false;
  cah.log.error("The server seems to have restarted. Any in-progress games have been lost.");
  cah.log.error("You will need to refresh the page to start a new game.");
  $("input").attr("disabled", "disabled");
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.NEW_PLAYER] = function(data) {
  // don't display our own join
  if (data.nickname != cah.nickname) {
    cah.log.status(data.nickname + " has connected.");
  }
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.PLAYER_LEAVE] = function(data) {
  var friendly_reason = "Leaving";
  switch (data.reason) {
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
  cah.log.status(data.nickname + " has disconnected (" + friendly_reason + ").");
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
  if (data.from != cah.nickname) {
    cah.log.status("<" + data.from + "> " + data.message);
  }
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_LIST_REFRESH] = function(data) {
  cah.GameList.instance.refreshGames();
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
