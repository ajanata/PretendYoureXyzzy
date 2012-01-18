package net.socialgamer.cah;

public class Constants {
  public interface ReturnableData {
  }

  public interface Localizable {
    public String getString();
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

  public enum AjaxOperation {
    CHAT("chat"),
    FIRST_LOAD("firstload"),
    GAME_LIST("games"),
    LOG_OUT("logout"),
    NAMES("names"),
    REGISTER("register");

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
    ERROR("error"),
    ERROR_CODE("error_code"),
    GAMES("games"),
    IN_PROGRESS("in_progress"),
    MAX_GAMES("max_games"),
    NAMES("names"),
    NEXT("next"),
    NICKNAME("nickname"),
    SERIAL(AjaxRequest.SERIAL.toString());

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
    BAD_OP("bad_op", "Invalid operation."),
    BAD_REQUEST("bad_req", "Bad request."),
    INVALID_NICK("invalid_nick", "Nickname must contain only upper and lower case letters, " +
        "numbers, or underscores, must be 3 to 30 characters long, and must not start with a " +
        "number."),
    MESSAGE_TOO_LONG("msg_too_long", "Messages cannot be longer than 200 characters."),
    NICK_IN_USE("nick_in_use", "Nickname is already in use."),
    NO_MSG_SPECIFIED("no_msg_spec", "No message specified."),
    NO_NICK_SPECIFIED("no_nick_spec", "No nickname specified."),
    NO_SESSION("no_session", "Session not detected. Make sure you have cookies enabled."),
    NOT_REGISTERED("not_registered", "Not registered. Refresh the page."),
    OP_NOT_SPECIFIED("op_not_spec", "Operation not specified."),
    SESSION_EXPIRED("session_expired", "Your session has expired. Refresh the page.");

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
    ERROR(AjaxResponse.ERROR.toString()),
    ERROR_CODE(AjaxResponse.ERROR_CODE.toString()),
    EVENT("event"),
    FROM("from"),
    GAME_ID("game_id"),
    MESSAGE("message"),
    NICKNAME("nickname"),
    REASON("reason"),
    TIMESTAMP("timestamp");

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

  public enum GameState implements Localizable {
    DEALING("dealing", "Dealing"),
    LOBBY("lobby", "Joinable (Not Started)");

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
}
