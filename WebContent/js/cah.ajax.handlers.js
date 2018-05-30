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
 * AJAX callback handlers. TODO make this individual files instead of all in one.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */

cah.ajax.StoreClientInformation_ = function(data) {
  cah.nickname = data[cah.$.AjaxResponse.NICKNAME];
  cah.idcode = data[cah.$.AjaxResponse.ID_CODE];
  cah.sigil = data[cah.$.AjaxResponse.SIGIL];
  if (!cah.noPersistentId) {
    cah.persistentId = data[cah.$.AjaxResponse.PERSISTENT_ID];
    cah.setCookie("persistent_id", cah.persistentId);
  }
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.REGISTER] = function(data) {
  cah.ajax.StoreClientInformation_(data);
  cah.log.status("You are connected as " + cah.sigil + cah.nickname);
  $("#welcome").hide();
  $("#canvass").show();

  cah.logUserPermalinks(data);
  cah.ajax.after_registered();
};

cah.ajax.ErrorHandlers[cah.$.AjaxOperation.REGISTER] = function(data) {
  $("#nickbox_error").text(cah.$.ErrorCode_msg[data[cah.$.AjaxResponse.ERROR_CODE]]);
  $("#nickname").focus();
};

// hacky way to avoid joining a game from the hash if the server told us to join a game.
cah.ajax.hasAutojoinedGame_ = false;
cah.ajax.SuccessHandlers[cah.$.AjaxOperation.FIRST_LOAD] = function(data) {
  cah.CardSet.populateCardSets(data[cah.$.AjaxResponse.CARD_SETS]);

  if (data[cah.$.AjaxResponse.IN_PROGRESS]) {
    cah.ajax.StoreClientInformation_(data);
    cah.log.status("You have reconnected as " + cah.nickname);
    cah.logUserPermalinks(data);
    $("#welcome").hide();
    $("#canvass").show();
    cah.ajax.after_registered();

    switch (data[cah.$.AjaxResponse.NEXT]) {
      case cah.$.ReconnectNextAction.GAME:
        cah.log.status("Reconnecting to game...");
        cah.Game.joinGame(data[cah.$.AjaxResponse.GAME_ID], data);
        cah.ajax.hasAutojoinedGame_ = true;
        break;
      case cah.$.ReconnectNextAction.NONE:
        // pass
        break;
      default:
        cah.log.error("Unknown reconnect next action " + data[cah.$.AjaxResponse.NEXT]);
    }
  }
};

// this is kinda hacky, but we need to re-try this operation ONCE if we didn't have a session.
cah.ajax.hasRetriedFirstLoad_ = false;
cah.ajax.ErrorHandlers[cah.$.AjaxOperation.FIRST_LOAD] = function(data) {
  if (data[cah.$.AjaxResponse.ERROR_CODE] == cah.$.ErrorCode.SESSION_EXPIRED
      && !cah.ajax.hasRetriedFirstLoad_) {
    cah.ajax.hasRetriedFirstLoad_ = true;
    cah.Ajax.build(cah.$.AjaxOperation.FIRST_LOAD).run();
  } else {
    cah.ajax.ErrorHandlers[cah.$.AjaxOperation.REGISTER](data);
  }
};

// another hack thing to trigger an auto-join after the first game list refresh
cah.ajax.autojoinGameId_ = undefined;
/**
 * This should only be called after we have a valid registration with the server, as we start doing
 * long polling here.
 */
cah.ajax.after_registered = function() {
  cah.log.debug("done registering");
  $("#canvas").removeClass("hide");
  $("#bottom").removeClass("hide");
  // TODO once there are channels, this needs to specify the global channel
  cah.Ajax.build(cah.$.AjaxOperation.NAMES).run();
  if (!cah.GLOBAL_CHAT_ENABLED) {
    cah.log.error("IMPORTANT: Global chat has been disabled.");
  }
  cah.GameList.instance.show();
  cah.GameList.instance.update();
  cah.longpoll.longPoll();
  // Dirty that we have to do this here... Oh well.
  app_resize();

  var hash = window.location.hash.substring(1);
  if (hash && hash != '') {
    // TODO find a better place for this if we ever have more than just game=id in the hash.
    var params = hash.split('&');
    var options = {};
    for ( var i in params) {
      var split = params[i].split('=');
      var key = split[0];
      var value = split[1];
      options[key] = value;
    }
    if (options['game']) {
      cah.ajax.autojoinGameId_ = options['game'];
    }
  }
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.CHAT] = function(data) {
  // pass
};

cah.ajax.ErrorHandlers[cah.$.AjaxOperation.CHAT] = function(data, req) {
  cah.log.status_with_game(req[cah.$.AjaxRequest.GAME_ID], "Error: "
      + cah.$.ErrorCode_msg[data[cah.$.AjaxResponse.ERROR_CODE]], "error")
};
cah.ajax.ErrorHandlers[cah.$.AjaxOperation.GAME_CHAT] = cah.ajax.ErrorHandlers[cah.$.AjaxOperation.CHAT];

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.GAME_CHAT] = function(data) {
  // pass
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.LOG_OUT] = function(data) {
  window.location.reload();
};

cah.ajax.ErrorHandlers[cah.$.AjaxOperation.LOG_OUT] = cah.ajax.SuccessHandlers[cah.$.AjaxOperation.LOG_OUT];

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.NAMES] = function(data) {
  cah.log.status("Currently connected: " + data[cah.$.AjaxResponse.NAMES].join(", "));
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.GAME_LIST] = function(data) {
  cah.GameList.instance.processUpdate(data);

  if (cah.ajax.autojoinGameId_ && !cah.ajax.hasAutojoinedGame_) {
    try {
      cah.GameList.instance.joinGame(cah.ajax.autojoinGameId_);
    } catch (e) {
      cah.log.error(e);
      cah.updateHash('');
    }
    cah.ajax.autojoinGameId_ = undefined;
  }
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.JOIN_GAME] = function(data, req) {
  cah.Game.joinGame(req[cah.$.AjaxRequest.GAME_ID], data);
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.SPECTATE_GAME] = cah.ajax.SuccessHandlers[cah.$.AjaxOperation.JOIN_GAME];

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.CREATE_GAME] = function(data) {
  cah.Game.joinGame(data[cah.$.AjaxResponse.GAME_ID], data);
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.GET_GAME_INFO] = function(data, req) {
  var game = cah.currentGames[req[cah.$.AjaxRequest.GAME_ID]];
  if (game) {
    game.updateGameStatus(data);
  }
};

cah.ajax.ErrorHandlers[cah.$.AjaxOperation.GET_GAME_INFO] = function(data, req) {
  if (data[cah.$.AjaxResponse.ERROR_CODE] == cah.$.ErrorCode.INVALID_GAME) {
    cah.log.error("The game has been removed. Returning to the lobby.");
    cah.ajax.SuccessHandlers[cah.$.AjaxOperation.LEAVE_GAME](data, req);
  } else {
    cah.log.error(cah.$.ErrorCode_msg[data[cah.$.AjaxResponse.ERROR_CODE]]);
  }
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.LEAVE_GAME] = function(data, req) {
  var game = cah.currentGames[req[cah.$.AjaxRequest.GAME_ID]];
  if (game) {
    game.dispose();
    delete cah.currentGames[req[cah.$.AjaxRequest.GAME_ID]];
  }
  cah.GameList.instance.show();
  cah.GameList.instance.update();
};

cah.ajax.ErrorHandlers[cah.$.AjaxOperation.LEAVE_GAME] = function(data, req) {
  if (data[cah.$.AjaxResponse.ERROR_CODE] == cah.$.ErrorCode.INVALID_GAME) {
    cah.ajax.SuccessHandlers[cah.$.AjaxOperation.LEAVE_GAME](data, req);
  } else {
    cah.log.error(cah.$.ErrorCode_msg[data[cah.$.AjaxResponse.ERROR_CODE]]);
  }
};

cah.ajax.ErrorHandlers[cah.$.AjaxOperation.START_GAME] = function(data, req) {
  if (data[cah.$.AjaxResponse.ERROR_CODE] == cah.$.ErrorCode.NOT_ENOUGH_CARDS) {
    var msg = "With current settings, the game requires "
        + data[cah.$.ErrorInformation.BLACK_CARDS_REQUIRED] + " black cards and "
        + data[cah.$.ErrorInformation.WHITE_CARDS_REQUIRED] + " white cards, but only has "
        + data[cah.$.ErrorInformation.BLACK_CARDS_PRESENT] + " black cards and "
        + data[cah.$.ErrorInformation.WHITE_CARDS_PRESENT] + " white cards.";

    cah.log.status_with_game(req[cah.$.AjaxRequest.GAME_ID], msg, "error");
  } else {
    cah.log.error(cah.$.ErrorCode_msg[data[cah.$.AjaxResponse.ERROR_CODE]]);
  }
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.START_GAME] = function(data, req) {
  var game = cah.currentGames[data[cah.$.AjaxRequest.GAME_ID]];
  if (game) {
    game.startGameComplete();
  }
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.STOP_GAME] = function(data, req) {
  // pass
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.GET_CARDS] = function(data, req) {
  var gameId = req[cah.$.AjaxRequest.GAME_ID];
  var game = cah.currentGames[gameId];
  if (game) {
    game.dealtCards(data[cah.$.AjaxResponse.HAND]);
    if (data[cah.$.AjaxResponse.BLACK_CARD]) {
      game.setBlackCard(data[cah.$.AjaxResponse.BLACK_CARD]);
    }
    if (data[cah.$.AjaxResponse.WHITE_CARDS]) {
      game.setRoundWhiteCards(data[cah.$.AjaxResponse.WHITE_CARDS]);
    }
  } else {
    cah.log.error("Received hand for unknown game id " + gameId);
  }
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.PLAY_CARD] = function(data, req) {
  var gameId = req[cah.$.AjaxRequest.GAME_ID];
  var game = cah.currentGames[gameId];
  if (game) {
    game.playCardComplete();
  }
};

cah.ajax.ErrorHandlers[cah.$.AjaxOperation.PLAY_CARD] = function(data) {
  cah.log.error(cah.$.ErrorCode_msg[data[cah.$.AjaxResponse.ERROR_CODE]]);

  var gameId = req[cah.$.AjaxRequest.GAME_ID];
  var game = cah.currentGames[gameId];
  if (game) {
    game.playCardError();
  }
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.JUDGE_SELECT] = function(data) {
  // pass
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.CHANGE_GAME_OPTIONS] = function(data) {
  // pass
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.KICK] = function(data) {
  // pass
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.BAN] = function(data) {
  // pass
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.SCORE] = function(data, req) {
  var gameId = req[cah.$.AjaxRequest.GAME_ID];
  var info = data[cah.$.AjaxResponse.PLAYER_INFO];
  var msg = info[cah.$.GamePlayerInfo.NAME] + " has " + info[cah.$.GamePlayerInfo.SCORE]
      + " Awesome Points.";
  if (gameId) {
    cah.log.status_with_game(gameId, msg);
  } else {
    cah.log.status(msg);
  }
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.CARDCAST_ADD_CARDSET] = function(data) {
  // pass
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.CARDCAST_REMOVE_CARDSET] = function(data) {
  // pass
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.CARDCAST_LIST_CARDSETS] = function(data, req) {
  var gameId = req[cah.$.AjaxRequest.GAME_ID];
  var game = cah.currentGames[gameId];
  if (game) {
    game.listCardcastDecks(data[cah.$.AjaxResponse.CARD_SETS]);
  }
};

cah.ajax.SuccessHandlers[cah.$.AjaxOperation.WHOIS] = function(data, req) {
  var chatWindowId = req[cah.$.AjaxRequest.GAME_ID];
  var nick = data[cah.$.AjaxResponse.NICKNAME];
  var sigil = data[cah.$.AjaxResponse.SIGIL];
  cah.log.status_with_game(chatWindowId, "Whois information for " + sigil + nick + ":");
  if (cah.$.Sigil.ADMIN == sigil) {
    cah.log.status_with_game(chatWindowId, "* <strong>Is an administrator</strong>", null, true);
  }
  if (data[cah.$.AjaxResponse.ID_CODE] != "") {
    cah.log.status_with_game(chatWindowId, "* Verification code: "
        + data[cah.$.AjaxResponse.ID_CODE]);
  }
  if (data[cah.$.AjaxResponse.IP_ADDRESS]) {
    cah.log.status_with_game(chatWindowId, "* Hostname: " + data[cah.$.AjaxResponse.IP_ADDRESS]);
  }
  if (data[cah.$.AjaxResponse.CLIENT_NAME]) {
    cah.log.status_with_game(chatWindowId, "* Client: " + data[cah.$.AjaxResponse.CLIENT_NAME]);
  }
  var gameId = data[cah.$.AjaxResponse.GAME_ID];
  if (undefined !== gameId) {
    var gameInfo = data[cah.$.AjaxResponse.GAME_INFO];
    var stateMsg = cah.$.GameState_msg[gameInfo[cah.$.GameInfo.STATE]];
    for (var i = 0; i < gameInfo[cah.$.GameInfo.SPECTATORS].length; i++) {
      if (gameInfo[cah.$.GameInfo.SPECTATORS][i] == nick) {
        stateMsg += ", Spectating";
        break;
      }
    }
    cah.log.status_with_game(chatWindowId, "* Game: <a onclick='$(\"#filter_games\").val(\"" + nick
        + "\").keyup()' class='gamelink'>#" + gameId + "</a>, " + stateMsg, null, true);
  }
  cah.log.status_with_game(chatWindowId, "* Connected at "
      + new Date(data[cah.$.AjaxResponse.CONNECTED_AT]).toLocaleString());
  var idle = new Date(data[cah.$.AjaxResponse.IDLE]);
  cah.log.status_with_game(chatWindowId, "* Idle " + idle.getUTCHours() + " hours "
      + idle.getUTCMinutes() + " mins " + idle.getUTCSeconds() + " secs");
  cah.log.status_with_game(chatWindowId, "End of whois information");
};
