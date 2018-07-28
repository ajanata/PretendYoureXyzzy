/**
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

package net.socialgamer.cah;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

import net.socialgamer.cah.data.Game;


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

  public static final int CHAT_FLOOD_MESSAGE_COUNT = 4;
  public static final int CHAT_FLOOD_TIME = 30 * 1000;
  public static final int CHAT_MAX_LENGTH = 200;

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
  public enum DisconnectReason implements Localizable {
    /**
     * The client was banned by the server administrator.
     */
    BANNED("B&", "Banned"),
    /**
     * The client made no user-caused requests within the timeout window.
     */
    IDLE_TIMEOUT("it", "Kicked due to idle"),
    /**
     * The client was kicked by the server administrator.
     */
    KICKED("k", "Kicked by server administrator"),
    /**
     * The user clicked the "log out" button.
     */
    MANUAL("man", "Leaving"),
    /**
     * The client failed to make any queries within the timeout window.
     */
    PING_TIMEOUT("pt", "Ping timeout");

    private final String reason;
    private final String message;

    DisconnectReason(final String reason, final String message) {
      this.reason = reason;
      this.message = message;
    }

    @Override
    public String toString() {
      return reason;
    }

    @Override
    public String getString() {
      return message;
    }
  }

  /**
   * The next thing the client should do during reconnect phase.
   *
   * Leaving these as longer strings as they are only used once per client.
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
    ADMIN_SET_VERBOSE_LOG("svl"),
    BAN("b"),
    CARDCAST_ADD_CARDSET("cac"),
    CARDCAST_LIST_CARDSETS("clc"),
    CARDCAST_REMOVE_CARDSET("crc"),
    CHANGE_GAME_OPTIONS("cgo"),
    CHAT("c"),
    CREATE_GAME("cg"),
    FIRST_LOAD("fl"),
    GAME_CHAT("GC"),
    GAME_LIST("ggl"),
    /**
     * Get all cards for a particular game: black, hand, and round white cards.
     */
    GET_CARDS("gc"),
    GET_GAME_INFO("ggi"),
    JOIN_GAME("jg"),
    SPECTATE_GAME("vg"),
    JUDGE_SELECT("js"),
    KICK("K"),
    LEAVE_GAME("lg"),
    LOG_OUT("lo"),
    /**
     * Get the names of all clients connected to the server.
     */
    NAMES("gn"),
    PLAY_CARD("pc"),
    REGISTER("r"),
    SCORE("SC"),
    START_GAME("sg"),
    STOP_GAME("Sg"),
    WHOIS("Wi");

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
  @GoStruct
  public enum AjaxRequest {
    @GoDataType("int")
    CARD_ID("cid"),
    CARDCAST_ID("cci"),
    @GoDataType("bool")
    EMOTE("me"),
    @GoDataType("int")
    GAME_ID("gid"),
    @GoDataType("GameOptionData")
    GAME_OPTIONS("go"),
    ID_CODE("idc"),
    MESSAGE("m"),
    NICKNAME("n"),
    OP("o"),
    PASSWORD("pw"),
    PERSISTENT_ID("pid"),
    @GoDataType("int")
    SERIAL("s"),
    @GoDataType("bool")
    WALL("wall");

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
  @GoStruct
  public enum AjaxResponse implements ReturnableData {
    @GoDataType("int")
    BLACK_CARD("bc"),
    @DuplicationAllowed
    @GoDataType("int")
    CARD_ID(AjaxRequest.CARD_ID),
    @GoDataType("[]CardSetData")
    CARD_SETS("css"),
    CLIENT_NAME("cn"),
    @GoDataType("int64")
    CONNECTED_AT("ca"),
    @GoDataType("bool")
    ERROR("e"),
    ERROR_CODE("ec"),
    // This is explicitly a pointer to the value, and not just the value. We need to be able to tell
    // the difference between game 0, and lack of game id.
    // This could be done with an explicit unmarshaller for the type, and a sentinel value, but that
    // would require significantly more work on the code generation.
    @DuplicationAllowed
    @GoDataType("*int")
    GAME_ID(AjaxRequest.GAME_ID),
    @GoDataType("GameInfo")
    GAME_INFO("gi"),
    @DuplicationAllowed
    @GoDataType("GameOptionData")
    GAME_OPTIONS(AjaxRequest.GAME_OPTIONS),
    GAME_STATE_DESCRIPTION("gss"),
    GAME_PERMALINK("gp"),
    @GoDataType("[]GameInfo")
    GAMES("gl"),
    @GoDataType("bool")
    GAME_CHAT_ENABLED("Gce"),
    @GoDataType("bool")
    GLOBAL_CHAT_ENABLED("gce"),
    @GoDataType("[]int")
    HAND("h"),
    @DuplicationAllowed
    ID_CODE(AjaxRequest.ID_CODE),
    @GoDataType("int64")
    IDLE("idl"),
    IP_ADDRESS("IP"),
    /**
     * Whether this client is reconnecting or not.
     */
    @GoDataType("bool")
    IN_PROGRESS("ip"),
    @GoDataType("int")
    MAX_GAMES("mg"),
    @GoDataType("[]string")
    NAMES("nl"),
    /**
     * Next thing that should be done in reconnect process. Used once, long string OK.
     */
    NEXT("next"),
    @DuplicationAllowed
    NICKNAME(AjaxRequest.NICKNAME),
    @DuplicationAllowed
    PERSISTENT_ID(AjaxRequest.PERSISTENT_ID),
    @GoDataType("[]GamePlayerInfo")
    PLAYER_INFO("pi"),
    /**
     * Sigil to display next to user's name.
     */
    SIGIL("?"),
    @DuplicationAllowed
    @GoDataType("int")
    SERIAL(AjaxRequest.SERIAL),
    @GoDataType("int64")
    SERVER_STARTED("SS"),
    SESSION_PERMALINK("sP"),
    USER_PERMALINK("up"),
    @GoDataType("[]int")
    WHITE_CARDS("wc");

    private final String field;

    AjaxResponse(final String field) {
      this.field = field;
    }

    AjaxResponse(final Enum<?> field) {
      this.field = field.toString();
    }

    @Override
    public String toString() {
      return field;
    }
  }

  // hmm this just gets dumped into the regular data it looks like
  public enum ErrorInformation implements ReturnableData {
    BLACK_CARDS_PRESENT("bcp"),
    BLACK_CARDS_REQUIRED("bcr"),
    WHITE_CARDS_PRESENT("wcp"),
    WHITE_CARDS_REQUIRED("wcr");

    private final String code;

    ErrorInformation(final String code) {
      this.code = code;
    }

    @Override
    public String toString() {
      return code;
    }
  }

  /**
   * Client request and long poll response errors.
   */
  public enum ErrorCode implements Localizable {
    ACCESS_DENIED("ad", "Access denied."),
    ALREADY_STARTED("as", "The game has already started."),
    ALREADY_STOPPED("aS", "The game has already stopped."),
    BAD_OP("bo", "Invalid operation."),
    BAD_REQUEST("br", "Bad request."),
    @DuplicationAllowed
    BANNED(DisconnectReason.BANNED, "Banned."),
    CANNOT_JOIN_ANOTHER_GAME("cjag", "You cannot join another game."),
    CAPSLOCK("CL", "Try turning caps lock off."),
    CARDCAST_CANNOT_FIND("ccf", "Cannot find Cardcast deck with given ID. If you just added this"
        + " deck to Cardcast, wait a few minutes and try again."),
    CARDCAST_INVALID_ID("cii", "Invalid Cardcast ID. Must be exactly 5 characters."),
    DO_NOT_HAVE_CARD("dnhc", "You don't have that card."),
    GAME_FULL("gf", "That game is full. Join another."),
    INVALID_CARD("ic", "Invalid card specified."),
    INVALID_GAME("ig", "Invalid game specified."),
    INVALID_ID_CODE("iid", "Identification code, if provided, must be between 8 and 100 characters,"
        + " inclusive."),
    /**
     * TODO this probably should be pulled in from a static inside the RegisterHandler.
     */
    INVALID_NICK("in", "Nickname must contain only upper and lower case letters, " +
        "numbers, or underscores, must be 3 to 30 characters long, and must not start with a " +
        "number."),
    /**
     * TODO this probably should be pulled in from a static inside the ChatHandler.
     */
    MESSAGE_TOO_LONG("mtl", "Messages cannot be longer than " + CHAT_MAX_LENGTH + " characters."),
    NICK_IN_USE("niu", "Nickname is already in use."),
    NO_CARD_SPECIFIED("ncs", "No card specified."),
    NO_GAME_SPECIFIED("ngs", "No game specified."),
    NO_MSG_SPECIFIED("nms", "No message specified."),
    NO_NICK_SPECIFIED("nns", "No nickname specified."),
    NO_SESSION("ns", "Session not detected. Make sure you have cookies enabled."),
    NO_SUCH_USER("nsu", "No such user."),
    NOT_ADMIN("na", "You are not an administrator."),
    NOT_ENOUGH_CARDS("nec", "You must add card sets containing at least "
        + Game.MINIMUM_BLACK_CARDS + " black cards and " + Game.MINIMUM_WHITE_CARDS_PER_PLAYER
        + " times the player limit white cards."),
    NOT_ENOUGH_PLAYERS("nep", "There are not enough players to start the game."),
    NOT_ENOUGH_SPACES("nes", "You must use more words in a message that long."),
    NOT_GAME_HOST("ngh", "Only the game host can do that."),
    NOT_IN_THAT_GAME("nitg", "You are not in that game."),
    NOT_JUDGE("nj", "You are not the judge."),
    NOT_REGISTERED("nr", "Not registered. Refresh the page."),
    NOT_YOUR_TURN("nyt", "It is not your turn to play a card."),
    OP_NOT_SPECIFIED("ons", "Operation not specified."),
    PLAYED_ALL_CARDS("pac", "You already played all the necessary cards!"),
    RESERVED_NICK("rn", "That nick is reserved."),
    REPEAT_MESSAGE("rm",
        "You can't repeat the same message multiple times in a row."),
    REPEATED_WORDS("rW", "You must use more unique words in your message."),
    SERVER_ERROR("serr", "An error occurred on the server."),
    SESSION_EXPIRED("se", "Your session has expired. Refresh the page."),
    TOO_FAST("tf", "You are chatting too fast. Wait a few seconds and try again."),
    TOO_MANY_GAMES("tmg", "There are too many games already in progress. Either join " +
        "an existing game, or wait for one to become available."),
    TOO_MANY_SPECIAL_CHARACTERS("tmsc",
        "You used too many special characters in that message."),
    TOO_MANY_USERS("tmu", "There are too many users connected. Either join another server, or " +
        "wait for a user to disconnect."),
    WRONG_PASSWORD("wp", "That password is incorrect.");

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

    ErrorCode(final Enum<?> code, final String message) {
      this.code = code.toString();
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
    @DuplicationAllowed
    BANNED(DisconnectReason.BANNED),
    @DuplicationAllowed
    CARDCAST_ADD_CARDSET(AjaxOperation.CARDCAST_ADD_CARDSET),
    @DuplicationAllowed
    CARDCAST_REMOVE_CARDSET(AjaxOperation.CARDCAST_REMOVE_CARDSET),
    @DuplicationAllowed
    CHAT(AjaxOperation.CHAT),
    FILTERED_CHAT("FC"),
    GAME_BLACK_RESHUFFLE("gbr"),
    GAME_JUDGE_LEFT("gjl"),
    GAME_JUDGE_SKIPPED("gjs"),
    GAME_LIST_REFRESH("glr"),
    GAME_OPTIONS_CHANGED("goc"),
    GAME_PLAYER_INFO_CHANGE("gpic"),
    GAME_PLAYER_JOIN("gpj"),
    GAME_PLAYER_KICKED_IDLE("gpki"),
    GAME_PLAYER_LEAVE("gpl"),
    GAME_PLAYER_SKIPPED("gps"),
    GAME_SPECTATOR_JOIN("gvj"),
    GAME_SPECTATOR_LEAVE("gvl"),
    GAME_ROUND_COMPLETE("grc"),
    GAME_STATE_CHANGE("gsc"),
    GAME_WHITE_RESHUFFLE("gwr"),
    HAND_DEAL("hd"),
    HURRY_UP("hu"),
    @DuplicationAllowed
    KICKED(DisconnectReason.KICKED),
    KICKED_FROM_GAME_IDLE("kfgi"),
    NEW_PLAYER("np"),
    /**
     * There has been no other action to inform the client about in a certain timeframe, so inform
     * the client that we have nothing to inform them so the client doesn't think we went away.
     */
    NOOP("_"),
    PLAYER_LEAVE("pl");

    private final String event;

    LongPollEvent(final String event) {
      this.event = event;
    }

    LongPollEvent(final Enum<?> event) {
      this.event = event.toString();
    }

    @Override
    public String toString() {
      return event;
    }
  }

  /**
   * Data keys that can be in a long poll response.
   */
  @GoStruct
  public enum LongPollResponse implements ReturnableData {
    @DuplicationAllowed
    @GoDataType("BlackCardData")
    BLACK_CARD(AjaxResponse.BLACK_CARD),
    CARDCAST_DECK_INFO("cdi"),
    @DuplicationAllowed
    @GoDataType("bool")
    EMOTE(AjaxRequest.EMOTE),
    @DuplicationAllowed
    @GoDataType("bool")
    ERROR(AjaxResponse.ERROR),
    @DuplicationAllowed
    ERROR_CODE(AjaxResponse.ERROR_CODE),
    EVENT("E"),
    /**
     * Player a chat message is from.
     */
    FROM("f"),
    /**
     * A chat message is from an admin. This is going to be done with IP addresses for now.
     * @deprecated Compare the SIGIL field to Sigil.ADMIN.
     */
    @Deprecated
    @GoDataType("bool")
    FROM_ADMIN("fa"),
    // This is explicitly a pointer to the value, and not just the value. We need to be able to tell
    // the difference between game 0, and lack of game id.
    // This could be done with an explicit unmarshaller for the type, and a sentinel value, but that
    // would require significantly more work on the code generation.
    @DuplicationAllowed
    @GoDataType("*int")
    GAME_ID(AjaxResponse.GAME_ID),
    @DuplicationAllowed
    @GoDataType("GameInfo")
    GAME_INFO(AjaxResponse.GAME_INFO),
    @DuplicationAllowed
    GAME_PERMALINK(AjaxResponse.GAME_PERMALINK),
    GAME_STATE("gs"),
    @DuplicationAllowed
    @GoDataType("[]WhiteCardData")
    HAND(AjaxResponse.HAND),
    @DuplicationAllowed
    ID_CODE(AjaxRequest.ID_CODE),
    /**
     * The delay until the next game round begins.
     */
    @GoDataType("int")
    INTERMISSION("i"),
    @DuplicationAllowed
    MESSAGE(AjaxRequest.MESSAGE),
    @DuplicationAllowed
    NICKNAME(AjaxRequest.NICKNAME),
    @GoDataType("int")
    PLAY_TIMER("Pt"),
    @DuplicationAllowed
    @GoDataType("[]GamePlayerInfo")
    PLAYER_INFO(AjaxResponse.PLAYER_INFO),
    /**
     * Reason why a player disconnected.
     */
    REASON("qr"),
    ROUND_PERMALINK("rP"),
    ROUND_WINNER("rw"),
    /**
     * Sigil to display next to user's name.
     */
    @DuplicationAllowed
    SIGIL(AjaxResponse.SIGIL),
    @GoDataType("int64")
    TIMESTAMP("ts"),
    @DuplicationAllowed
    @GoDataType("bool")
    WALL(AjaxRequest.WALL),
    @DuplicationAllowed
    @GoDataType("[][]WhiteCardData")
    WHITE_CARDS(AjaxResponse.WHITE_CARDS),
    // This is just the ID of one of the cards played by the winner
    @GoDataType("int")
    WINNING_CARD("WC");

    private final String field;

    LongPollResponse(final String field) {
      this.field = field;
    }

    LongPollResponse(final Enum<?> field) {
      this.field = field.toString();
    }

    @Override
    public String toString() {
      return field;
    }
  }

  /**
   * User sigils. Displayed before the user's name.
   */
  public enum Sigil {
    ADMIN("@"), ID_CODE("+"), NORMAL_USER("");

    private final String sigil;

    Sigil(final String sigil) {
      this.sigil = sigil;
    }

    @Override
    public String toString() {
      return sigil;
    }
  }

  /**
   * Data fields for white cards.
   */
  @GoStruct
  public enum WhiteCardData {
    @DuplicationAllowed
    @GoDataType("int")
    ID(AjaxRequest.CARD_ID),
    TEXT("T"),
    WATERMARK("W"),
    @GoDataType("bool")
    WRITE_IN("wi");

    private final String key;

    WhiteCardData(final String key) {
      this.key = key;
    }

    WhiteCardData(final Enum<?> key) {
      this.key = key.toString();
    }

    @Override
    public String toString() {
      return key;
    }
  }

  /**
   * Data fields for black cards.
   */
  @GoStruct
  public enum BlackCardData {
    @GoDataType("int")
    DRAW("D"),
    @DuplicationAllowed
    @GoDataType("int")
    ID(WhiteCardData.ID),
    @GoDataType("int")
    PICK("PK"),
    @DuplicationAllowed
    TEXT(WhiteCardData.TEXT),
    @DuplicationAllowed
    WATERMARK(WhiteCardData.WATERMARK);

    private final String key;

    BlackCardData(final String key) {
      this.key = key;
    }

    BlackCardData(final Enum<?> key) {
      this.key = key.toString();
    }

    @Override
    public String toString() {
      return key;
    }
  }

  /**
   * Data fields for card sets.
   */
  @GoStruct
  public enum CardSetData {
    @GoDataType("bool")
    BASE_DECK("bd"),
    @GoDataType("int")
    BLACK_CARDS_IN_DECK("bcid"),
    CARD_SET_DESCRIPTION("csd"),
    CARD_SET_NAME("csn"),
    @DuplicationAllowed
    @GoDataType("int")
    ID(WhiteCardData.ID),
    @GoDataType("int")
    WEIGHT("w"),
    @GoDataType("int")
    WHITE_CARDS_IN_DECK("wcid");

    private final String key;

    CardSetData(final String key) {
      this.key = key;
    }

    CardSetData(final Enum<?> key) {
      this.key = key.toString();
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
    JUDGING("j", "In Progress"),
    LOBBY("l", "Not Started"),
    PLAYING("p", "In Progress"),
    ROUND_OVER("ro", "In Progress");

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
  @GoStruct
  public enum GameInfo {
    @GoDataType("int64")
    CREATED("gca"),
    HOST("H"),
    @DuplicationAllowed
    @GoDataType("int")
    ID(AjaxRequest.GAME_ID),
    @DuplicationAllowed
    @GoDataType("GameOptionData")
    GAME_OPTIONS(AjaxRequest.GAME_OPTIONS),
    @GoDataType("bool")
    HAS_PASSWORD("hp"),
    @GoDataType("[]string")
    PLAYERS("P"),
    @GoDataType("[]string")
    SPECTATORS("V"),
    STATE("S");

    private final String key;

    GameInfo(final String key) {
      this.key = key;
    }

    GameInfo(final Enum<?> key) {
      this.key = key.toString();
    }

    @Override
    public String toString() {
      return key;
    }
  }

  /**
   * Fields for options about a game.
   */
  @GoStruct
  public enum GameOptionData {
    @GoDataType("int")
    BLANKS_LIMIT("bl"),
    @DuplicationAllowed
    @GoDataType("[]int")
    CARD_SETS(AjaxResponse.CARD_SETS),
    @DuplicationAllowed
    PASSWORD(AjaxRequest.PASSWORD),
    @GoDataType("int")
    PLAYER_LIMIT("pL"),
    @GoDataType("int")
    SPECTATOR_LIMIT("vL"),
    @GoDataType("int")
    SCORE_LIMIT("sl"),
    TIMER_MULTIPLIER("tm");

    private final String key;

    GameOptionData(final String key) {
      this.key = key;
    }

    GameOptionData(final Enum<?> key) {
      this.key = key.toString();
    }

    @Override
    public String toString() {
      return key;
    }
  }

  /**
   * Keys for the information about players in a game.
   */
  @GoStruct
  public enum GamePlayerInfo {
    NAME("N"),
    @GoDataType("int")
    SCORE("sc"),
    STATUS("st");

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
    HOST("sh", "Host", "Wait for players then click Start Game."),
    IDLE("si", "", "Waiting for players..."),
    JUDGE("sj", "Card Czar", "You are the Card Czar."),
    JUDGING("sjj", "Selecting", "Select a winning card."),
    PLAYING("sp", "Playing", "Select a card to play."),
    WINNER("sw", "Winner!", "You have won!"),
    SPECTATOR("sv", "Spectator", "You are just spectating.");

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

  /**
   * Mark an enum value as being allowed to be the same as another enum value. Should only be used
   * when another enum's value is directly used as the value. This will prevent the test from
   * flagging it as an invalid reuse.
   */
  @Retention(RetentionPolicy.RUNTIME)
  public @interface DuplicationAllowed {
  }

  /**
   * Mark an enum to generate a struct for it in the Go output. This would be used for things that
   * describe objects, not a list of valid values for a field.
   */
  @Retention(RetentionPolicy.RUNTIME)
  public @interface GoStruct {
  }

  /**
   * Mark an enum value as having a specific Go data type. The default (if this annotation is not
   * specified) is string.
   */
  @Retention(RetentionPolicy.RUNTIME)
  public @interface GoDataType {
    String value() default "string";
  }
}
