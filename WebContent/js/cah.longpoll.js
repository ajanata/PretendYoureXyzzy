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
 * AJAX long polling library.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */

cah.longpoll = {};
cah.longpoll.TIMEOUT = 30 * 1000;

/**
 * Backoff when there was an error.
 * 
 * @type {number}
 */
cah.longpoll.INITIAL_BACKOFF = 500;

/**
 * Backoff after a successful request.
 * 
 * @type {number}
 */
cah.longpoll.NORMAL_BACKOFF = 1;

/**
 * Current backkoff.
 * 
 * @type {number}
 */
cah.longpoll.Backoff = cah.longpoll.INITIAL_BACKOFF;
cah.longpoll.Resume = true;
cah.longpoll.ErrorCodeHandlers = {};
cah.longpoll.EventHandlers = {};

/**
 * Start a long polling operation.
 */
cah.longpoll.longPoll = function() {
  cah.log.debug("starting long poll");
  $.ajax({
    cache : false,
    complete : cah.longpoll.complete,
    error : cah.longpoll.error,
    success : cah.longpoll.done,
    timeout : cah.longpoll.TIMEOUT,
    url : cah.LONGPOLL_URI,
  });
};

/**
 * Called when a long polling operation completes, success or failure. Will start another poll
 * unless the previous one ended in a terminal failure (likely because the server restarted and we
 * no longer have a session on it).
 */
cah.longpoll.complete = function() {
  if (cah.longpoll.Resume) {
    setTimeout("cah.longpoll.longPoll()", cah.longpoll.Backoff);
  }
};

/**
 * Called when a long polling operation completes successfully. Dispatches the events to the
 * appropriate handler.
 * 
 * @param {Array}
 *          data_list A list of events to process.
 */
cah.longpoll.done = function(data_list) {
  cah.log.debug("long poll done", data_list);

  var data_list_work;
  // we need to handle non-array data, too, so just make it look like an array
  if (data_list[cah.$.LongPollResponse.TIMESTAMP] || data_list[cah.$.LongPollResponse.ERROR]) {
    data_list_work = {};
    data_list_work[0] = data_list;
  } else {
    data_list_work = data_list;
  }

  for ( var index in data_list_work) {
    var data = data_list_work[index];
    if (data[cah.$.LongPollResponse.ERROR]) {
      // TODO cancel any timers or whatever we may have, and disable interface
      // this probably should be done in the appropriate error code handler because we may not
      // want to always be that extreme.
      var errorCode = data[cah.$.LongPollResponse.ERROR_CODE];
      if (cah.longpoll.ErrorCodeHandlers[errorCode]) {
        cah.longpoll.ErrorCodeHandlers[errorCode](data);
      } else {
        cah.log.error(cah.$.ErrorCode_msg[errorCode]);
      }
    } else {
      // FIXME giant hack
      if (data[cah.$.LongPollResponse.PLAY_TIMER]) {
        $("#current_timer").text(data[cah.$.LongPollResponse.PLAY_TIMER] / 1000);
      }
      var event = data[cah.$.LongPollResponse.EVENT];
      if (cah.longpoll.EventHandlers[event]) {
        cah.longpoll.EventHandlers[event](data);
      } else {
        cah.log.error("Unhandled event " + event);
      }
    }
  }

  // reset the backoff to normal when there's a successful operation
  cah.longpoll.Backoff = cah.longpoll.NORMAL_BACKOFF;
};

/**
 * Called when a long polling operation completes with an error.
 */
cah.longpoll.error = function(jqXHR, textStatus, errorThrown) {
  // TODO deal with this somehow
  cah.log.debug(textStatus);
  if (cah.longpoll.Backoff < cah.longpoll.INITIAL_BACKOFF) {
    cah.longpoll.Backoff = cah.longpoll.INITIAL_BACKOFF;
  } else {
    cah.longpoll.Backoff *= 2;
  }
  cah.log
      .error("Error communicating with server. Will try again in " + (cah.longpoll.Backoff / 1000)
          + " second" + (cah.longpoll.Backoff != 1000 ? "s" : "") + ".");
};
