/**
 * Logging functions.
 * 
 * @author ajanata
 */

cah.log = {};

cah.log.status = function(text, opt_class) {
  var scroll = $("#log").prop("scrollHeight") - $("#log").height() - $("#log").prop("scrollTop") <= 5;

  var node = $("<span></span><br/>");
  $(node).text("[" + new Date().toLocaleTimeString() + "] " + text + "\n");
  if (opt_class) {
    $(node).addClass(opt_class);
  }
  $("#log").append(node);

  if (scroll) {
    $("#log").prop("scrollTop", $("#log").prop("scrollHeight"));
  }
};

cah.log.error = function(text) {
  cah.log.status("Error: " + text, "error");
};

/**
 * Log a message if debugging is enabled, optionally dumping the contents of an object.
 * 
 * @param {string}
 *          text Text to display
 * @param {object}
 *          opt_obj Optional. Object to dump along with message.
 */
cah.log.debug = function(text, opt_obj) {
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
