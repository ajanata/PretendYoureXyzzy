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

cah.longpoll.EventHandlers[cah.$.LongPollEvent.CHAT] = function(data) {
  // TODO deal with multiple channels eventually
  // don't display our own chat
  if (data.from != cah.nickname) {
    cah.log.status("<" + data.from + "> " + data.message);
  }
};

cah.longpoll.EventHandlers[cah.$.LongPollEvent.GAME_REFRESH] = function(data) {
  cah.GameList.instance.refreshGames();
};
