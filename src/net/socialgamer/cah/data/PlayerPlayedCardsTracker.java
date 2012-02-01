package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.socialgamer.cah.db.WhiteCard;


public class PlayerPlayedCardsTracker {
  private final Map<Player, List<WhiteCard>> playerCardMap = new HashMap<Player, List<WhiteCard>>();
  private final Map<Integer, Player> reverseIdMap = new HashMap<Integer, Player>();

  public void addCard(final Player player, final WhiteCard card) {
    List<WhiteCard> cards = playerCardMap.get(player);
    if (cards == null) {
      cards = new ArrayList<WhiteCard>(3);
      playerCardMap.put(player, cards);
    }
    reverseIdMap.put(card.getId(), player);
    cards.add(card);
  }

  public boolean hasPlayerForId(final int id) {
    return reverseIdMap.containsKey(id);
  }

  public Player getPlayerForId(final int id) {
    return reverseIdMap.get(id);
  }

  public boolean hasPlayer(final Player player) {
    return playerCardMap.containsKey(player);
  }

  /**
   * @param player
   * @return The list of cards {@code player} has played this round, or {@code null} if they have
   *         not played any cards.
   */
  public List<WhiteCard> getCards(final Player player) {
    return playerCardMap.get(player);
  }

  public List<WhiteCard> remove(final Player player) {
    final List<WhiteCard> cards = playerCardMap.remove(player);
    if (cards != null && cards.size() > 0) {
      reverseIdMap.remove(cards.get(0).getId());
    }
    return cards;
  }

  public int size() {
    return playerCardMap.size();
  }

  public Set<Player> playedPlayers() {
    return playerCardMap.keySet();
  }

  public void clear() {
    playerCardMap.clear();
    reverseIdMap.clear();
  }

  public Collection<List<WhiteCard>> cards() {
    return playerCardMap.values();
  }
}
