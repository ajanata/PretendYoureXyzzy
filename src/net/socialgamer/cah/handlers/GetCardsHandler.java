package net.socialgamer.cah.handlers;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.Constants.WhiteCardData;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class GetCardsHandler extends GameWithPlayerHandler {

  @Inject
  public GetCardsHandler(final GameManager gameManager) {
    super(gameManager);
  }

  public static final String OP = AjaxOperation.GET_CARDS.toString();

  @SuppressWarnings("unchecked")
  @Override
  public Map<ReturnableData, Object> handleWithUserInGame(final RequestWrapper request,
      final HttpSession session, final User user, final Game game) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();

    final List<Map<WhiteCardData, Object>> hand = game.getHand(user);
    if (hand != null) {
      data.put(AjaxResponse.HAND, hand);
    } else {
      data.put(AjaxResponse.HAND, Arrays.asList(new HashMap<WhiteCardData, Object>()));
    }
    data.put(AjaxResponse.BLACK_CARD, game.getBlackCard());

    data.put(AjaxResponse.GAME_ID, game.getId());
    return data;
  }
}
