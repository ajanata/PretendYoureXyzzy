package net.socialgamer.cah.handlers;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.GameInfo;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.GameManager.MaxGames;

import com.google.inject.Inject;


public class GameListHandler extends Handler {

  public static final String OP = AjaxOperation.GAME_LIST.toString();

  private final GameManager gameManager;
  private final int maxGames;

  @Inject
  public GameListHandler(final GameManager gameManager, @MaxGames final Integer maxGames) {
    this.gameManager = gameManager;
    this.maxGames = maxGames;
  }

  @Override
  public Map<ReturnableData, Object> handle(final RequestWrapper request,
      final HttpSession session) {
    final Map<ReturnableData, Object> ret = new HashMap<ReturnableData, Object>();
    final Collection<Game> games = gameManager.getGameList();
    final List<Map<GameInfo, Object>> gameInfos =
        new ArrayList<Map<GameInfo, Object>>(games.size());
    for (final Game game : games) {
      gameInfos.add(game.getInfo());
    }
    ret.put(AjaxResponse.GAMES, gameInfos);
    ret.put(AjaxResponse.MAX_GAMES, maxGames);
    return ret;
  }
}
