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
  cah.log.status(data.nickname + " has connected.");
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
