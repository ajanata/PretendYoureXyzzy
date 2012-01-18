package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.SessionAttribute;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class CreateGameHandler extends Handler {

  public static final String OP = AjaxOperation.CREATE_GAME.toString();

  private final GameManager gameManager;
  private final ConnectedUsers users;

  @Inject
  public CreateGameHandler(final GameManager gameManager, final ConnectedUsers users) {
    this.gameManager = gameManager;
    this.users = users;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session) {
    final Map<ReturnableData, Object> ret = new HashMap<ReturnableData, Object>();

    final User user = (User) session.getAttribute(SessionAttribute.USER);
    assert (user != null);

    Game game;
    try {
      game = gameManager.createGameWithPlayer(user);
    } catch (final IllegalStateException ise) {
      return error(ErrorCode.CANNOT_JOIN_GAME);
    }
    if (game == null) {
      return error(ErrorCode.TOO_MANY_GAMES);
    } else {
      ret.put(AjaxResponse.GAME_ID, game.getId());
      return ret;
    }
  }
}
