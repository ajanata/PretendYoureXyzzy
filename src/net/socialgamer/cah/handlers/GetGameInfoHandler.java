package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class GetGameInfoHandler extends GameHandler {

  public static final String OP = AjaxOperation.GET_GAME_INFO.toString();

  @Inject
  public GetGameInfoHandler(final GameManager gameManager) {
    super(gameManager);
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session, final User user, final Game game) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();

    data.put(AjaxResponse.GAME_INFO, game.getInfo());
    data.put(AjaxResponse.PLAYER_INFO, game.getAllPlayerInfo());
    return data;
  }
}
