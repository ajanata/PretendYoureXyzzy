/**
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

package net.socialgamer.cah;

/**
 * Constants needed on both the CAH server and client. This file is examined with reflection to
 * produce a Javascript version for the client to use.
 * 
 * All of the enums in here take a string in their constructor to define the over-the-wire value to
 * be used to represent that enum value. This allows for verbose names while debugging, and short
 * names to reduce traffic and latency, by only having to change it in one place for both the server
 * and client.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class Constants {
  /**
   * Enums that implement this interface are valid keys for data returned to clients.
   */
  public interface ReturnableData {
  }

  /**
   * Enums that implement this interface have a user-visible string associated with them.
   * 
   * There presently is not support for localization, but the name fits.
   */
  public interface Localizable {
    /**
     * @return The user-visible string that is associated with this enum value.
     */
    public String getString();
  }

  /**
   * Enums that implement this interface have two user-visible strings associated with them.
   * 
   * There presently is not support for localization, but the name fits.
   */
  public interface DoubleLocalizable {
    /**
     * @return The first user-visible string that is associated with this enum value.
     */
    public String getString();

    /**
     * @return The second user-visible string that is associated with this enum value.
     */
    public String getString2();
  }

  /**
   * Reason why a client disconnected.
   */
  public enum DisconnectReason {
    /**
     * The client was kicked by the server administrator.
     */
    KICKED("kicked"),
    /**
     * The user clicked the "log out" button.
     */
    MANUAL("manual"),
    /**
     * The client failed to make any queries within the timeout window.
     */
    PING_TIMEOUT("ping_timeout");

    private final String reason;

    DisconnectReason(final String reason) {
      this.reason = reason;
    }

    @Override
    public String toString() {
      return reason;
    }
  }

  /**
   * The next thing the client should do during reconnect phase.
   */
  public enum ReconnectNextAction {
    /**
     * The client should load a game as part of the reconnect process.
     */
    GAME("game"),
    /**
     * There is nothing for the client to reload, perhaps because they were not in any special
     * state, or they are a new client.
     */
    NONE("none");

    private final String action;

    ReconnectNextAction(final String action) {
      this.action = action;
    }

    @Override
    public String toString() {
      return action;
    }
  }

  /**
   * Valid client request operations.
   */
  public enum AjaxOperation {
    ADMIN_SET_VERBOSE_LOG("set_verbose_log"),
    CHAT("chat"),
    CREATE_GAME("create_game"),
    FIRST_LOAD("firstload"),
    GAME_LIST("games"),
    /**
     * Get all cards for a particular game: black, hand, and round white cards.
     */
    GET_CARDS("get_cards"),
    GET_GAME_INFO("get_game_info"),
    JOIN_GAME("join_game"),
    JUDGE_SELECT("judge_select"),
    LEAVE_GAME("leave_game"),
    LOG_OUT("logout"),
    /**
     * Get the names of all clients connected to the server.
     */
    NAMES("names"),
    PLAY_CARD("play_card"),
    REGISTER("register"),
    START_GAME("start_game");

    private final String op;

    AjaxOperation(final String op) {
      this.op = op;
    }

    @Override
    public String toString() {
      return op;
    }
  }

  /**
   * Parameters for client requests.
   */
  public enum AjaxRequest {
    CARD_ID("card_id"),
    GAME_ID("game_id"),
    MESSAGE("message"),
    NICKNAME("nickname"),
    OP("op"),
    SERIAL("serial");

    private final String field;

    AjaxRequest(final String field) {
      this.field = field;
    }

    @Override
    public String toString() {
      return field;
    }
  }

  /**
   * Keys for client request responses.
   */
  public enum AjaxResponse implements ReturnableData {
    BLACK_CARD("black_card"),
    CARD_ID(AjaxRequest.CARD_ID.toString()),
    ERROR("error"),
    ERROR_CODE("error_code"),
    GAME_ID("game_id"),
    GAME_INFO("game_info"),
    GAMES("games"),
    HAND("hand"),
    /**
     * Whether this client is reconnecting or not.
     */
    IN_PROGRESS("in_progress"),
    MAX_GAMES("max_games"),
    NAMES("names"),
    /**
     * Next thing that should be done in reconnect process.
     */
    NEXT("next"),
    NICKNAME(AjaxRequest.NICKNAME.toString()),
    PLAYER_INFO("player_info"),
    SERIAL(AjaxRequest.SERIAL.toString()),
    WHITE_CARDS("white_cards");

    private final String field;

    AjaxResponse(final String field) {
      this.field = field;
    }

    @Override
    public String toString() {
      return field;
    }
  }

  /**
   * Client request and long poll response errors.
   */
  public enum ErrorCode implements Localizable {
    ACCESS_DENIED("access_denied", "Access denied."),
    ALREADY_STARTED("already_started", "The game has already started."),
    BAD_OP("bad_op", "Invalid operation."),
    BAD_REQUEST("bad_req", "Bad request."),
    CANNOT_JOIN_ANOTHER_GAME("cannot_join_another_game", "You cannot join another game."),
    DO_NOT_HAVE_CARD("do_not_have_card", "You don't have that card."),
    GAME_FULL("game_full", "That game is full. Join another."),
    INVALID_CARD("invalid_card", "Invalid card specified."),
    INVALID_GAME("invalid_game", "Invalid game specified."),
    /**
     * TODO this probably should be pulled in from a static inside the RegisterHandler.
     */
    INVALID_NICK("invalid_nick", "Nickname must contain only upper and lower case letters, " +
        "numbers, or underscores, must be 3 to 30 characters long, and must not start with a " +
        "number."),
    /**
     * TODO this probably should be pulled in from a static inside the ChatHandler.
     */
    MESSAGE_TOO_LONG("msg_too_long", "Messages cannot be longer than 200 characters."),
    NICK_IN_USE("nick_in_use", "Nickname is already in use."),
    NO_CARD_SPECIFIED("no_card_spec", "No card specified."),
    NO_GAME_SPECIFIED("no_game_spec", "No game specified."),
    NO_MSG_SPECIFIED("no_msg_spec", "No message specified."),
    NO_NICK_SPECIFIED("no_nick_spec", "No nickname specified."),
    NO_SESSION("no_session", "Session not detected. Make sure you have cookies enabled."),
    NOT_ENOUGH_PLAYERS("not_enough_players", "There are not enough players to start the game."),
    NOT_GAME_HOST("not_game_host", "Only the game host can do that."),
    NOT_IN_THAT_GAME("not_in_that_game", "You are not in that game."),
    NOT_JUDGE("not_judge", "You aren't the judge."),
    NOT_REGISTERED("not_registered", "Not registered. Refresh the page."),
    NOT_YOUR_TURN("not_your_turn", "It is not your turn to play a card."),
    OP_NOT_SPECIFIED("op_not_spec", "Operation not specified."),
    SERVER_ERROR("server_error", "An error occured on the server."),
    SESSION_EXPIRED("session_expired", "Your session has expired. Refresh the page."),
    TOO_MANY_GAMES("too_many_games", "There are too many games already in progress. Either join " +
        "an existing game, or wait for one to become available.");

    private final String code;
    private final String message;

    /**
     * @param code
     *          Error code to send over the wire to the client.
     * @param message
     *          Message the client should display for the error code.
     */
    ErrorCode(final String code, final String message) {
      this.code = code;
      this.message = message;
    }

    @Override
    public String toString() {
      return code;
    }

    @Override
    public String getString() {
      return message;
    }
  }

  /**
   * Events that can be returned in a long poll response.
   */
  public enum LongPollEvent {
    CHAT("chat"),
    GAME_BLACK_RESHUFFLE("game_black_reshuffle"),
    GAME_JUDGE_LEFT("game_judge_left"),
    GAME_LIST_REFRESH("game_list_refresh"),
    GAME_PLAYER_INFO_CHANGE("game_player_info_change"),
    GAME_PLAYER_JOIN("game_player_join"),
    GAME_PLAYER_LEAVE("game_player_leave"),
    GAME_ROUND_COMPLETE("game_round_complete"),
    GAME_STATE_CHANGE("game_state_change"),
    GAME_WHITE_RESHUFFLE("game_white_reshuffle"),
    HAND_DEAL("hand_deal"),
    KICKED("kicked"),
    NEW_PLAYER("new_player"),
    /**
     * There has been no other action to inform the client about in a certain timeframe, so inform
     * the client that we have nothing to inform them so the client doesn't think we went away.
     */
    NOOP("noop"),
    PLAYER_LEAVE("player_leave");

    private final String event;

    LongPollEvent(final String event) {
      this.event = event;
    }

    @Override
    public String toString() {
      return event;
    }
  }

  /**
   * Data keys that can be in a long poll response.
   */
  public enum LongPollResponse implements ReturnableData {
    BLACK_CARD(AjaxResponse.BLACK_CARD.toString()),
    ERROR(AjaxResponse.ERROR.toString()),
    ERROR_CODE(AjaxResponse.ERROR_CODE.toString()),
    EVENT("event"),
    /**
     * Player a chat message is from.
     */
    FROM("from"),
    GAME_ID(AjaxResponse.GAME_ID.toString()),
    GAME_STATE("game_state"),
    HAND("hand"),
    /**
     * The delay until the next game round begins.
     */
    INTERMISSION("intermission"),
    MESSAGE("message"),
    NICKNAME(AjaxRequest.NICKNAME.toString()),
    PLAYER_INFO(AjaxResponse.PLAYER_INFO.toString()),
    /**
     * Reason why a player disconnected.
     */
    REASON("reason"),
    ROUND_WINNER("round_winner"),
    TIMESTAMP("timestamp"),
    WHITE_CARDS("white_cards"),
    WINNING_CARD("winning_card");

    private final String field;

    LongPollResponse(final String field) {
      this.field = field;
    }

    @Override
    public String toString() {
      return field;
    }
  }

  /**
   * Data fields for white cards.
   */
  public enum WhiteCardData {
    ID("id"),
    TEXT("text");

    private final String key;

    WhiteCardData(final String key) {
      this.key = key;
    }

    @Override
    public String toString() {
      return key;
    }
  }

  /**
   * Data fields for black cards.
   */
  public enum BlackCardData {
    DRAW("draw"),
    ID(WhiteCardData.ID.toString()),
    PICK("pick"),
    TEXT(WhiteCardData.TEXT.toString());

    private final String key;

    BlackCardData(final String key) {
      this.key = key;
    }

    @Override
    public String toString() {
      return key;
    }
  }

  /**
   * A game's current state.
   */
  public enum GameState implements Localizable {
    DEALING("dealing", "In Progress"),
    JUDGING("judging", "In Progress"),
    LOBBY("lobby", "Not Started"),
    PLAYING("playing", "In Progress"),
    ROUND_OVER("round_over", "In Progress");

    private final String state;
    private final String message;

    GameState(final String state, final String message) {
      this.state = state;
      this.message = message;
    }

    @Override
    public String toString() {
      return state;
    }

    @Override
    public String getString() {
      return message;
    }
  }

  /**
   * Fields for information about a game.
   */
  public enum GameInfo {
    HOST("host"),
    ID("id"),
    PLAYERS("players"),
    STATE("state");

    private final String key;

    GameInfo(final String key) {
      this.key = key;
    }

    @Override
    public String toString() {
      return key;
    }
  }

  /**
   * Keys for the information about players in a game.
   */
  public enum GamePlayerInfo {
    NAME("name"),
    SCORE("score"),
    STATUS("status");

    private final String key;

    GamePlayerInfo(final String key) {
      this.key = key;
    }

    @Override
    public String toString() {
      return key;
    }
  }

  /**
   * States that a player in a game can be in. The first client string is displayed in the
   * scoreboard, and the second one is displayed in a banner at the top, telling the user what to
   * do.
   */
  public enum GamePlayerStatus implements DoubleLocalizable {
    HOST("host", "Host", "Wait for players then click Start Game."),
    IDLE("idle", "", "Waiting for players..."),
    JUDGE("judge", "Card Czar", "You are the Card Czar."),
    JUDGING("judging", "Selecting", "Select a winning card."),
    PLAYING("playing", "Playing", "Select a card to play."),
    WINNER("winner", "Winner!", "You have won!");

    private final String status;
    private final String message;
    private final String message2;

    GamePlayerStatus(final String status, final String message, final String message2) {
      this.status = status;
      this.message = message;
      this.message2 = message2;
    }

    @Override
    public String toString() {
      return status;
    }

    @Override
    public String getString() {
      return message;
    }

    @Override
    public String getString2() {
      return message2;
    }
  }

  /**
   * Attributes stored in a client session.
   */
  public class SessionAttribute {
    public static final String USER = "user";
  }
}
