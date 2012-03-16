package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxRequest;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.GameState;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class ChangeGameOptionHandler extends GameWithPlayerHandler {

  public static final String OP = AjaxOperation.CHANGE_GAME_OPTIONS.toString();

  @Inject
  public ChangeGameOptionHandler(final GameManager gameManager) {
    super(gameManager);
  }

  @Override
  public Map<ReturnableData, Object> handleWithUserInGame(final RequestWrapper request,
      final HttpSession session, final User user, final Game game) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();

    if (game.getHost() != user) {
      return error(ErrorCode.NOT_GAME_HOST);
    } else if (game.getState() != GameState.LOBBY) {
      return error(ErrorCode.ALREADY_STARTED);
    } else {
      try {
        final int scoreLimit = Integer.parseInt(request.getParameter(AjaxRequest.SCORE_LIMIT));
        final int playerLimit = Integer.parseInt(request.getParameter(AjaxRequest.PLAYER_LIMIT));
        final int cardSet = Integer.parseInt(request.getParameter(AjaxRequest.CARD_SET));
        game.updateGameSettings(scoreLimit, playerLimit, cardSet);
      } catch (final NumberFormatException nfe) {
        return error(ErrorCode.BAD_REQUEST);
      }
      return data;
    }
  }
}
