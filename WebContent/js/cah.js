/*
 * Copyright (c) 2012-2017, Andy Janata
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
 * Global data and helper functions.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */

var cah = {};

/**
 * This client's nickname.
 * 
 * @type {string}
 */
cah.nickname = "";

/**
 * The games this client is playing in. Key is game id.
 * 
 * @type {Object}
 */
cah.currentGames = {};

/**
 * User's ignore list. Map of nickname -> true. If a nickname is present, it is ignored.
 * 
 * @type {Object}
 */
cah.ignoreList = {};

/**
 * Whether to hide connect/disconnect messages.
 * 
 * @type {Boolean}
 */
cah.hideConnectQuit = false;

/**
 * Whether to ignore the persistent ID the server gives us.
 * 
 * @type {Boolean}
 */
cah.noPersistentId = false;

/**
 * Our persistent ID.
 * 
 * @type {string}
 */
cah.persistentId = null;

/**
 * Whether the game's browser window has focus, so we don't update the game list when we're not
 * active.
 * 
 * @type {Boolean}
 */
cah.windowActive = true;

/**
 * Whether we've missed a game list refresh due to not being the active window.
 * 
 * @type {Boolean}
 */
cah.missedGameListRefresh = false;

/**
 * Binds a function to a "this object". Result is a new function that will do the right thing across
 * contexts.
 * 
 * @param {Object}
 *          selfObj Object for "this" when calling the returned function.
 * @param {Function}
 *          func Function to call with selfObjc as "this".
 * @returns {Function}
 */
cah.bind = function(selfObj, func) {
  return function() {
    func.apply(selfObj, arguments);
  };
};

/**
 * Inherit the proto methods from one constructor to another.
 * 
 * @param {Function}
 *          childCtor Child class.
 * @param {Function}
 *          parentCtor Parent class.
 */
cah.inherits = function(childCtor, parentCtor) {
  /** @constructor */
  function tempCtor() {
    // pass
  }
  ;

  tempCtor.prototype = parentCtor.prototype;
  childCtor.superClass_ = parentCtor.prototype;
  childCtor.prototype = new tempCtor();
  childCtor.prototype.constructor = childCtor;
};

/**
 * Updates the hash in the browser's URL for deeplinks.
 * 
 * TODO: If we ever want more than just game=id here, this will have to deal with a map somehow.
 * 
 * @param {String}
 *          hash The hash to use in the URL.
 */
cah.updateHash = function(hash) {
  window.location.replace(window.location.protocol + '//' + window.location.host
      + window.location.pathname.replace(/#$/g, '') + '#' + hash);
};
