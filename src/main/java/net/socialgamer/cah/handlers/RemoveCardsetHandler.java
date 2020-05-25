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

public class RemoveCardsetHandler extends GameWithPlayerHandler {

  public static final String OP = AjaxOperation.REMOVE_CARDSET.toString();

  private final CustomCardsService customCardsService;

  @Inject
  public RemoveCardsetHandler(final GameManager gameManager,
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
      String deckIdStr = request.getParameter(AjaxRequest.CUSTOM_CARDSET_ID);
      if (null == deckIdStr) {
        return error(ErrorCode.BAD_REQUEST);
      }

      int deckId;
      try {
        deckId = Integer.parseInt(deckIdStr);
      } catch (NumberFormatException e) {
        return error(ErrorCode.BAD_REQUEST);
      }

      // Remove it from the set regardless if it loads or not.
      game.getCustomDeckIds().remove(deckId);
      final CustomDeck deck = customCardsService.loadSet(deckId);
      if (null == deck) {
        return error(ErrorCode.CUSTOM_SET_CANNOT_FIND);
      }

      final HashMap<ReturnableData, Object> map = game.getEventMap();
      map.put(LongPollResponse.EVENT, LongPollEvent.REMOVE_CARDSET.toString());
      map.put(LongPollResponse.CUSTOM_DECK_INFO, deck.getClientMetadata());
      game.broadcastToPlayers(MessageType.GAME_EVENT, map);

      return data;
    }
  }

}
