package net.socialgamer.cah;

public class Constants {
  /**
   * Enums that implement this interface are valid keys for data returned to clients.
   * 
   * @author ajanata
   */
  public interface ReturnableData {
  }

  /**
   * Enums that implement this interface have a user-visible string associated with them.
   * 
   * @author ajanata
   */
  public interface Localizable {
    public String getString();
  }

  /**
   * Enums that implement this interface have two user-visible strings associated with them.
   * 
   * @author ajanata
   */
  public interface DoubleLocalizable {
    public String getString();

    public String getString2();
  }

  public enum DisconnectReason {
    KICKED("kicked"),
    MANUAL("manual"),
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

  public enum ReconnectNextAction {
    GAME("game"),
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

  public enum AjaxOperation {
    CHAT("chat"),
    CREATE_GAME("create_game"),
    FIRST_LOAD("firstload"),
    GAME_LIST("games"),
    GET_CARDS("get_cards"),
    GET_GAME_INFO("get_game_info"),
    JOIN_GAME("join_game"),
    LEAVE_GAME("leave_game"),
    LOG_OUT("logout"),
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

  public enum AjaxResponse implements ReturnableData {
    BLACK_CARD("black_card"),
    CARD_ID(AjaxRequest.CARD_ID.toString()),
    ERROR("error"),
    ERROR_CODE("error_code"),
    GAME_ID("game_id"),
    GAME_INFO("game_info"),
    GAMES("games"),
    HAND("hand"),
    IN_PROGRESS("in_progress"),
    MAX_GAMES("max_games"),
    NAMES("names"),
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

  public enum ErrorCode implements Localizable {
    ALREADY_STARTED("already_started", "The game has already started."),
    BAD_OP("bad_op", "Invalid operation."),
    BAD_REQUEST("bad_req", "Bad request."),
    CANNOT_JOIN_ANOTHER_GAME("cannot_join_another_game", "You cannot join another game."),
    DO_NOT_HAVE_CARD("do_not_have_card", "You don't have that card."),
    GAME_FULL("game_full", "That game is full. Join another."),
    INVALID_CARD("invalid_card", "Invalid card specified."),
    INVALID_GAME("invalid_game", "Invalid game specified."),
    INVALID_NICK("invalid_nick", "Nickname must contain only upper and lower case letters, " +
        "numbers, or underscores, must be 3 to 30 characters long, and must not start with a " +
        "number."),
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
    NOT_REGISTERED("not_registered", "Not registered. Refresh the page."),
    NOT_YOUR_TURN("not_your_turn", "It is not your turn to play a card."),
    OP_NOT_SPECIFIED("op_not_spec", "Operation not specified."),
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

  public enum LongPollEvent {
    CHAT("chat"),
    GAME_LIST_REFRESH("game_list_refresh"),
    GAME_PLAYER_INFO_CHANGE("game_player_info_change"),
    GAME_PLAYER_JOIN("game_player_join"),
    GAME_PLAYER_LEAVE("game_player_leave"),
    GAME_STATE_CHANGE("game_state_change"),
    HAND_DEAL("hand_deal"),
    NEW_PLAYER("new_player"),
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

  public enum LongPollResponse implements ReturnableData {
    BLACK_CARD(AjaxResponse.BLACK_CARD.toString()),
    ERROR(AjaxResponse.ERROR.toString()),
    ERROR_CODE(AjaxResponse.ERROR_CODE.toString()),
    EVENT("event"),
    FROM("from"),
    GAME_ID(AjaxResponse.GAME_ID.toString()),
    GAME_STATE("game_state"),
    HAND("hand"),
    MESSAGE("message"),
    NICKNAME(AjaxRequest.NICKNAME.toString()),
    PLAYER_INFO(AjaxResponse.PLAYER_INFO.toString()),
    REASON("reason"),
    TIMESTAMP("timestamp"),
    WHITE_CARDS("white_cards");

    private final String field;

    LongPollResponse(final String field) {
      this.field = field;
    }

    @Override
    public String toString() {
      return field;
    }
  }

  public class SessionAttribute {
    public static final String USER = "user";
  }

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

  public enum GameState implements Localizable {
    DEALING("dealing", "In Progress"),
    JUDGING("judging", "In Progress"),
    LOBBY("lobby", "Joinable (Not Started)"),
    PLAYING("playing", "In Progress");

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

  public enum GamePlayerStatus implements DoubleLocalizable {
    HOST("host", "Host", "Wait for players then click Start Game."),
    IDLE("idle", "", "Waiting for players..."),
    JUDGE("judge", "Judge", "You are the judge this round."),
    JUDGING("judging", "Judging", "Select a winning card."),
    PLAYING("playing", "Playing", "Select a card to play.");

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
}
