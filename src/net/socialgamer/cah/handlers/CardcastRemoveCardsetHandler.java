package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Constants.AjaxOperation;
import net.socialgamer.cah.Constants.AjaxRequest;
import net.socialgamer.cah.Constants.ErrorCode;
import net.socialgamer.cah.Constants.GameState;
import net.socialgamer.cah.Constants.LongPollEvent;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.RequestWrapper;
import net.socialgamer.cah.cardcast.CardcastDeck;
import net.socialgamer.cah.cardcast.CardcastService;
import net.socialgamer.cah.data.Game;
import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.QueuedMessage.MessageType;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;

public class CardcastRemoveCardsetHandler extends GameWithPlayerHandler {

  public static final String OP = AjaxOperation.CARDCAST_REMOVE_CARDSET.toString();

  private final CardcastService cardcastService;

  @Inject
  public CardcastRemoveCardsetHandler(final GameManager gameManager,
      final CardcastService cardcastService) {
    super(gameManager);
    this.cardcastService = cardcastService;
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
      String deckId = request.getParameter(AjaxRequest.CARDCAST_ID);
      if (null == deckId) {
        return error(ErrorCode.BAD_REQUEST);
      }
      deckId = deckId.toUpperCase();
      if (deckId.length() != 5) {
        return error(ErrorCode.CARDCAST_INVALID_ID);
      }

      // Remove it from the set regardless if it loads or not.
      game.getCardcastDeckIds().remove(deckId);
      final CardcastDeck deck = cardcastService.loadSet(deckId);
      if (null == deck) {
        return error(ErrorCode.CARDCAST_CANNOT_FIND);
      }

      final HashMap<ReturnableData, Object> map = game.getEventMap();
      map.put(LongPollResponse.EVENT, LongPollEvent.CARDCAST_REMOVE_CARDSET.toString());
      map.put(LongPollResponse.CARDCAST_DECK_INFO, deck.getClientMetadata());
      game.broadcastToPlayers(MessageType.GAME_EVENT, map);

      return data;
    }
  }

}
