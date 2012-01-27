package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxRequest;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class PlayCardHandler extends GameWithPlayerHandler {

  public static final String OP = AjaxOperation.PLAY_CARD.toString();

  @Inject
  public PlayCardHandler(final GameManager gameManager) {
    super(gameManager);
  }

  @Override
  public Map<ReturnableData, Object> handleWithUserInGame(final RequestWrapper request,
      final HttpSession session, final User user, final Game game) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();

    final int cardId;

    if (request.getParameter(AjaxRequest.CARD_ID) == null) {
      return error(ErrorCode.NO_CARD_SPECIFIED);
    }
    try {
      cardId = Integer.parseInt(request.getParameter(AjaxRequest.CARD_ID));
    } catch (final NumberFormatException nfe) {
      return error(ErrorCode.INVALID_CARD);
    }

    final ErrorCode ec = game.playCard(user, cardId);
    if (ec != null) {
      return error(ec);
    } else {
      return data;
    }
  }
}
