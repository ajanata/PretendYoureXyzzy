package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

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
        final int spectatorLimit = Integer.parseInt(request
            .getParameter(AjaxRequest.SPECTATOR_LIMIT));

        final String[] cardSetsParsed = request.getParameter(AjaxRequest.CARD_SETS).split(",");
        final Set<Integer> cardSetIds = new HashSet<Integer>();
        for (final String cardSetId : cardSetsParsed) {
          if (!cardSetId.isEmpty()) {
            cardSetIds.add(Integer.parseInt(cardSetId));
          }
        }

        final int blanksLimit = Integer.parseInt(request.getParameter(AjaxRequest.BLANKS_LIMIT));
        final String oldPassword = game.getPassword();
        String password = request.getParameter(AjaxRequest.PASSWORD);
        if (password == null) {
          password = "";
        }
        // We're not directly assigning this with Boolean.valueOf() because we want to default to
        // true if it isn't specified, though that should never happen.
        boolean useTimer = true;
        final String useTimerString = request.getParameter(AjaxRequest.USE_TIMER);
        if (null != useTimerString && !"".equals(useTimerString)) {
          useTimer = Boolean.valueOf(useTimerString);
        }
        game.updateGameSettings(scoreLimit, playerLimit, spectatorLimit, cardSetIds, blanksLimit,
            password, useTimer);

        // only broadcast an update if the password state has changed, because it needs to change
        // the text on the join button and the sort order
        if (!password.equals(oldPassword)) {
          gameManager.broadcastGameListRefresh();
        }
      } catch (final NumberFormatException nfe) {
        return error(ErrorCode.BAD_REQUEST);
      }

      return data;
    }
  }
}
