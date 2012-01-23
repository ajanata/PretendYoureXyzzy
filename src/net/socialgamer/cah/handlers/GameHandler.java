package net.socialgamer.cah.handlers;

import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxRequest;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;


public abstract class GameHandler extends Handler {

  protected GameManager gameManager;

  public GameHandler(final GameManager gameManager) {
    this.gameManager = gameManager;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request, final HttpSession session) {
    final User user = (User) session.getAttribute(SessionAttribute.USER);
    assert (user != null);

    final int gameId;

    if (request.getParameter(AjaxRequest.GAME_ID) == null) {
      return error(ErrorCode.NO_GAME_SPECIFIED);
    }
    try {
      gameId = Integer.parseInt(request.getParameter(AjaxRequest.GAME_ID));
    } catch (final NumberFormatException nfe) {
      return error(ErrorCode.INVALID_GAME);
    }

    final Game game = gameManager.getGame(gameId);
    if (game == null) {
      return error(ErrorCode.INVALID_GAME);
    }

    assert game.getId() == gameId : "Got a game with id not what we asked for.";

    return handle(request, session, user, game);
  }

  public abstract Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session, final User user, final Game game);
}
