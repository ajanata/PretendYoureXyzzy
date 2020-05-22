package net.socialgamer.cah.handlers;

import com.google.inject.Inject;
import net.socialgamer.cah.Constants.*;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.customsets.CustomCardsService;
import net.socialgamer.cah.customsets.CustomDeck;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.QueuedMessage.MessageType;
import net.socialgamer.cah.data.User;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

public class AddCardsetHandler extends GameWithPlayerHandler {

  public static final String OP = AjaxOperation.ADD_CARDSET.toString();

  private final CustomCardsService customCardsService;

  @Inject
  public AddCardsetHandler(final GameManager gameManager,
      final CustomCardsService customCardsService) {
    super(gameManager);
    this.customCardsService = customCardsService;
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
      String deckUrl = request.getParameter(AjaxRequest.CUSTOM_CARDSET_URL);
      String deckJson = request.getParameter(AjaxRequest.CUSTOM_CARDSET_JSON);
      if ((deckJson == null && deckUrl == null) || (deckJson != null && deckUrl != null)) {
        return error(ErrorCode.BAD_REQUEST);
      }

      CustomDeck deck;
      if (deckUrl != null) deck = customCardsService.loadSetFromUrl(deckUrl);
      else deck = customCardsService.loadSetFromJson(deckJson, null);

      if (null == deck) {
        return error(ErrorCode.CUSTOM_SET_CANNOT_FIND);
      }

      if (game.getCustomDeckIds().add(deck.getId())) {
        final HashMap<ReturnableData, Object> map = game.getEventMap();
        map.put(LongPollResponse.EVENT, LongPollEvent.ADD_CARDSET.toString());
        map.put(LongPollResponse.CUSTOM_DECK_INFO, deck.getClientMetadata());
        game.broadcastToPlayers(MessageType.GAME_EVENT, map);
      }

      return data;
    }
  }

}
