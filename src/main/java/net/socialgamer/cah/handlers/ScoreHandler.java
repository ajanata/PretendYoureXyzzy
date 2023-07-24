package net.socialgamer.cah.handlers;

import com.google.inject.Inject;
import net.socialgamer.cah.Constants.*;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.Player;
import net.socialgamer.cah.data.User;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;


public class ScoreHandler extends Handler {

  public static final String OP = AjaxOperation.SCORE.toString();

  private final ConnectedUsers connectedUsers;

  @Inject
  public ScoreHandler(final ConnectedUsers connectedUsers) {
    this.connectedUsers = connectedUsers;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request, final HttpSession session) {
    final User user = (User) session.getAttribute(SessionAttribute.USER);
    assert (user != null);
    final String params = request.getParameter(AjaxRequest.MESSAGE);
    final String[] args = (params == null || params.isEmpty()) ? new String[0] : params.trim()
            .split(" ");

    final User target = (args.length > 0) ? connectedUsers.getUser(args[0]) : user;
    if (null == target) {
      return error(ErrorCode.NO_SUCH_USER);
    }
    final Game game = target.getGame();
    if (null == game) {
      return error(ErrorCode.INVALID_GAME);
    }
    final Player player = game.getPlayerForUser(target);
    if (null == player) {
      return error(ErrorCode.INVALID_GAME);
    }

    final Map<ReturnableData, Object> data = new HashMap<>();

    if (user.isAdmin() && args.length == 2) {
      // for now only admins can change scores.  could possibly extend this to let the host do it,
      // provided it's for a player in the same game and it does a gamewide announcement.
      try {
        final int offset = Integer.parseInt(args[1]);
        player.increaseScore(offset);
        game.notifyPlayerInfoChange(player);
      } catch (final NumberFormatException e) {
        return error(ErrorCode.BAD_REQUEST);
      }
    }
    data.put(AjaxResponse.PLAYER_INFO, game.getPlayerInfo(player));

    return data;
  }
}
