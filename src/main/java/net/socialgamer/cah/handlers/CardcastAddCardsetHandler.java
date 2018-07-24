package net.socialgamer.cah.handlers;

import com.google.inject.Inject;
import net.socialgamer.cah.Constants.*;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.cardcast.CardcastDeck;
import net.socialgamer.cah.cardcast.CardcastService;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.QueuedMessage.MessageType;
import net.socialgamer.cah.data.User;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

public class CardcastAddCardsetHandler extends GameWithPlayerHandler {

  public static final String OP = AjaxOperation.CARDCAST_ADD_CARDSET.toString();

  private final CardcastService cardcastService;

  @Inject
  public CardcastAddCardsetHandler(final GameManager gameManager,
                                   final CardcastService cardcastService) {
    super(gameManager);
    this.cardcastService = cardcastService;
  }

  @Override
  public Map<ReturnableData, Object> handleWithUserInGame(final RequestWrapper request,
                                                          final HttpSession session, final User user, final Game game) {
    final Map<ReturnableData, Object> data = new HashMap<>();

    if (game.getHost() != user) {
      return error(ErrorCode.NOT_GAME_HOST);
    } else if (game.getState() != GameState.LOBBY) {
      return error(ErrorCode.ALREADY_STARTED);
    } else {
      String deckId = request.getParameter(AjaxRequest.CARDCAST_ID);
      if (null == deckId) {
        return error(ErrorCode.BAD_REQUEST);
      }
      deckId = deckId.toUpperCase();
      if (deckId.length() != 5) {
        return error(ErrorCode.CARDCAST_INVALID_ID);
      }

      final CardcastDeck deck = cardcastService.loadSet(deckId);
      if (null == deck) {
        return error(ErrorCode.CARDCAST_CANNOT_FIND);
      }

      final HashMap<ReturnableData, Object> map = game.getEventMap();
      map.put(LongPollResponse.EVENT, LongPollEvent.CARDCAST_ADD_CARDSET.toString());
      map.put(LongPollResponse.CARDCAST_DECK_INFO, deck.getClientMetadata());
      game.broadcastToPlayers(MessageType.GAME_EVENT, map);

      game.getCardcastDeckIds().add(deckId);

      return data;
    }
  }

}
