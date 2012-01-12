/**
 * Event handlers from long-poll operations.
 * 
 * @author ajanata
 */

cah.longpoll.ErrorCodeHandlers.not_registered = function(data) {
  cah.longpoll.Resume = false;
  // TODO disable interface
  cah.log.error("The server seems to have restarted. Any in-progress games have been lost.");
  cah.log.error("You will need to refresh the page to start a new game.");
};

cah.longpoll.EventHandlers.new_player = function(data) {
  // don't display our own join
  if (data.nickname != cah.nickname) {
    cah.log.status(data.nickname + " has connected.");
  }
};

cah.longpoll.EventHandlers.player_leave = function(data) {
  var friendly_reason = "Leaving";
  // see net.socialgamer.cah.data.User.DisconnectReason
  switch (data.reason) {
    case "MANUAL":
      friendly_reason = "Leaving";
      break;
    case "PING_TIMEOUT":
      friendly_reason = "Ping timeout";
      break;
    case "KICKED":
      friendly_reason = "Kicked by server";
      break;
  }
  cah.log.status(data.nickname + " has disconnected (" + friendly_reason + ").");
};

cah.longpoll.EventHandlers.noop = function(data) {
  // pass
};

cah.longpoll.EventHandlers.chat = function(data) {
  // TODO deal with multiple channels eventually
  // don't display our own chat
  if (data.from != cah.nickname) {
    cah.log.status("&lt;" + data.from + "&gt; " + data.message);
  }
};
