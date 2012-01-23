package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.Game.TooManyPlayersException;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class JoinGameHandler extends GameHandler {

  public static final String OP = AjaxOperation.JOIN_GAME.toString();

  @Inject
  public JoinGameHandler(final GameManager gameManager) {
    super(gameManager);
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session, final User user, final Game game) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();

    try {
      game.addPlayer(user);
    } catch (final IllegalStateException e) {
      return error(ErrorCode.CANNOT_JOIN_ANOTHER_GAME);
    } catch (final TooManyPlayersException e) {
      return error(ErrorCode.GAME_FULL);
    }

    // return the game id as a positive result to the client, which will then make another request
    // to actually get game data
    data.put(AjaxResponse.GAME_ID, game.getId());

    gameManager.broadcastGameListRefresh();

    return data;
  }

}
