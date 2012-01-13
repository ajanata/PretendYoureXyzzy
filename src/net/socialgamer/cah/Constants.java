package net.socialgamer.cah;

public class Constants {
  public interface ReturnableData {
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
    ERROR_MESSAGE("error_message"),
    IN_PROGRESS("in_progress"),
    NAMES("names"),
    NEXT("next"),
    NICKNAME("nickname"),
    SERIAL("serial");

    private final String field;

    AjaxResponse(final String field) {
      this.field = field;
    }

    @Override
    public String toString() {
      return field;
    }
  }

  public enum ErrorCode {
    BAD_OP("bad_op"),
    BAD_REQUEST("bad_req"),
    NO_SESSION("no_session"),
    NOT_REGISTERED("not_registered"),
    OP_NOT_SPECIFIED("op_not_spec"),
    SESSION_EXPIRED("session_expired");

    private final String code;

    ErrorCode(final String code) {
      this.code = code;
    }

    @Override
    public String toString() {
      return code;
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
}
