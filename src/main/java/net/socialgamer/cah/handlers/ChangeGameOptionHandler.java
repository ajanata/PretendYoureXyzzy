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
import net.socialgamer.cah.data.GameOptions;
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
        final String value = request.getParameter(AjaxRequest.GAME_OPTIONS);
        final GameOptions options = GameOptions.deserialize(value);
        final String oldPassword = game.getPassword();
        game.updateGameSettings(options);

        // only broadcast an update if the password state has changed, because it needs to change
        // the text on the join button and the sort order
        if (!game.getPassword().equals(oldPassword)) {
          gameManager.broadcastGameListRefresh();
        }
      } catch (final Exception e) {
        return error(ErrorCode.BAD_REQUEST);
      }

      return data;
    }
  }
}
