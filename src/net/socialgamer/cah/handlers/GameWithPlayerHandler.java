package net.socialgamer.cah.handlers;

import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;


public abstract class GameWithPlayerHandler extends GameHandler {

  public GameWithPlayerHandler(final GameManager gameManager) {
    super(gameManager);
  }

  @Override
  public final Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session, final User user, final Game game) {
    // TODO when multiple games per user are supported, we need to change this.
    if (user.getGame() != game) {
      return error(ErrorCode.NOT_IN_THAT_GAME);
    } else {
      return handleWithUserInGame(request, session, user, game);
    }
  }

  public abstract Map<ReturnableData, Object> handleWithUserInGame(final RequestWrapper request,
      final HttpSession session, final User user, final Game game);
}
