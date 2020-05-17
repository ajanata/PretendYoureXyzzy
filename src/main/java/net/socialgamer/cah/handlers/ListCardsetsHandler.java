package net.socialgamer.cah.handlers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxResponse;
import net.socialgamer.cah.Constants.CardSetData;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.customsets.CustomDeck;
import net.socialgamer.cah.customsets.CustomCardsService;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;

public class ListCardsetsHandler extends GameWithPlayerHandler {

  public static final String OP = AjaxOperation.LIST_CARDSETS.toString();

  private final CustomCardsService customCardsService;

  @Inject
  public ListCardsetsHandler(final GameManager gameManager,
                             final CustomCardsService customCardsService) {
    super(gameManager);
    this.customCardsService = customCardsService;
  }

  @Override
  public Map<ReturnableData, Object> handleWithUserInGame(final RequestWrapper request,
      final HttpSession session, final User user, final Game game) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();

    final List<Map<CardSetData, Object>> setDatas = new ArrayList<>();
    for (final Integer deckId : game.getCustomDeckIds().toArray(new Integer[0])) {
      final CustomDeck deck = customCardsService.loadSet(deckId);
      if (null == deck) {
        // FIXME we need a way to tell the user which one is broken.
        return error(ErrorCode.CUSTOM_SET_CANNOT_FIND);
      }
      setDatas.add(deck.getClientMetadata());
    }
    data.put(AjaxResponse.CARD_SETS, setDatas);

    return data;
  }
}
