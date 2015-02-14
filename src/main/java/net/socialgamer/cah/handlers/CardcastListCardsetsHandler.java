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
import net.socialgamer.cah.cardcast.CardcastDeck;
import net.socialgamer.cah.cardcast.CardcastService;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;

public class CardcastListCardsetsHandler extends GameWithPlayerHandler {

  public static final String OP = AjaxOperation.CARDCAST_LIST_CARDSETS.toString();

  private final CardcastService cardcastService;

  @Inject
  public CardcastListCardsetsHandler(final GameManager gameManager,
      final CardcastService cardcastService) {
    super(gameManager);
    this.cardcastService = cardcastService;
  }

  @Override
  public Map<ReturnableData, Object> handleWithUserInGame(final RequestWrapper request,
      final HttpSession session, final User user, final Game game) {
    final Map<ReturnableData, Object> data = new HashMap<ReturnableData, Object>();

    final List<Map<CardSetData, Object>> setDatas = new ArrayList<>();
    for (final String deckId : game.getCardcastDeckIds().toArray(new String[0])) {
      final CardcastDeck deck = cardcastService.loadSet(deckId);
      if (null == deck) {
        // FIXME we need a way to tell the user which one is broken.
        return error(ErrorCode.CARDCAST_CANNOT_FIND);
      }
      setDatas.add(deck.getClientMetadata());
    }
    data.put(AjaxResponse.CARD_SETS, setDatas);

    return data;
  }
}
