package net.socialgamer.cah.data;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import net.socialgamer.cah.Constants.LongPollEvent;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.data.Game.TooManyPlayersException;
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.data.QueuedMessage.MessageType;

import com.google.inject.BindingAnnotation;
import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;


/**
 * Manage games for the server.
 * 
 * This is also a Guice provider for game ids.
 * 
 * @author ajanata
 */
@Singleton
@GameId
public class GameManager implements Provider<Integer> {

  private final int maxGames;
  private final Map<Integer, Game> games = new TreeMap<Integer, Game>();
  private final Provider<Game> gameProvider;
  private final ConnectedUsers users;
  /**
   * Potential next game id.
   */
  private int nextId = 0;

  @Inject
  public GameManager(final Provider<Game> gameProvider, @MaxGames final Integer maxGames,
      final ConnectedUsers users) {
    this.gameProvider = gameProvider;
    this.maxGames = maxGames;
    this.users = users;
  }

  /**
   * Creates a new game, if there are free game slots. Returns null if there are already the maximum
   * number of games in progress.
   * 
   * @return Newly created game, or {@code null} if the maximum number of games are in progress.
   */
  private Game createGame() {
    synchronized (games) {
      if (games.size() >= maxGames) {
        return null;
      }
      final Game game = gameProvider.get();
      if (game.getId() < 0) {
        return null;
      }
      games.put(game.getId(), game);
      return game;
    }
  }

  /**
   * Creates a new game and puts the specified user into the game, if there are free game slots.
   * Returns null if there are already the maximum number of games in progress.
   * 
   * Creating the game and adding the user are done atomically with respect to another game getting
   * created, or even getting the list of active games. It is impossible for another user to join
   * the game before the requesting user.
   * 
   * @param user
   *          User to place into the game.
   * @return Newly created game, or {@code null} if the maximum number of games are in progress.
   * @throws IllegalStateException
   *           If the user is already in a game and cannot join another.
   */
  public Game createGameWithPlayer(final User user) throws IllegalStateException {
    synchronized (games) {
      final Game game = createGame();
      if (game == null) {
        return null;
      }
      try {
        game.addPlayer(user);
      } catch (final IllegalStateException ise) {
        destroyGame(game.getId());
        throw ise;
      } catch (final TooManyPlayersException tmpe) {
        // this should never happen -- we just made the game
        throw new Error("Impossible exception: Too many players in new game.", tmpe);
      }
      broadcastGameListRefresh();
      return game;
    }
  }

  /**
   * This probably will not be used very often in the server: Games should normally be deleted when
   * all players leave it. I'm putting this in if only to help with testing.
   * 
   * Destroys a game immediately. This will almost certainly cause errors on the client for any
   * players left in the game. If {@code gameId} isn't valid, this method silently returns.
   */
  public void destroyGame(final int gameId) {
    synchronized (games) {
      final Game game = games.remove(gameId);
      if (game == null) {
        return;
      }
      // if the prospective next id isn't valid, set it to the id we just removed
      if (nextId == -1 || games.containsKey(nextId)) {
        nextId = gameId;
      }
      // TODO remove the players from the game

      broadcastGameListRefresh();
    }
  }

  public void broadcastGameListRefresh() {
    final HashMap<ReturnableData, Object> broadcastData = new HashMap<ReturnableData, Object>();
    broadcastData.put(LongPollResponse.EVENT, LongPollEvent.GAME_LIST_REFRESH.toString());
    users.broadcastToAll(MessageType.GAME_EVENT, broadcastData);
  }

  /**
   * Get an unused game ID, or -1 if the maximum number of games are in progress. This should not be
   * called in such a case, though!
   * 
   * TODO: make this not suck
   * 
   * @return Next game id, or -1 if the maximum number of games are in progress.
   */
  @Override
  public Integer get() {
    synchronized (games) {
      if (games.size() >= maxGames) {
        return -1;
      }
      if (!games.containsKey(nextId) && nextId >= 0) {
        final int ret = nextId;
        nextId = candidateGameId(ret);
        return ret;
      } else {
        final int ret = candidateGameId();
        nextId = candidateGameId(ret);
        return ret;
      }
    }
  }

  private int candidateGameId() {
    return candidateGameId(-1);
  }

  private int candidateGameId(final int skip) {
    synchronized (games) {
      if (games.size() >= maxGames) {
        return -1;
      }
      for (int i = 0; i < maxGames; i++) {
        if (i == skip) {
          continue;
        }
        if (!games.containsKey(i)) {
          return i;
        }
      }
      return -1;
    }
  }

  public Collection<Game> getGameList() {
    synchronized (games) {
      // return a copy
      return new ArrayList<Game>(games.values());
    }
  }

  /**
   * Gets the game with the specified id, or {@code null} if there is no game with that id.
   * 
   * @param id
   *          Id of game to retrieve.
   * @return The Game, or {@code null} if there is no game with that id.
   */
  public Game getGame(final int id) {
    synchronized (games) {
      return games.get(id);
    }
  }

  Map<Integer, Game> getGames() {
    return games;
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface GameId {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface MaxGames {
  }
}
