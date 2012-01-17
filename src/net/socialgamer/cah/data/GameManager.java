package net.socialgamer.cah.data;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.util.Map;
import java.util.TreeMap;

import net.socialgamer.cah.data.GameManager.GameId;

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
  /**
   * Potential next game id.
   */
  private int nextId = 0;

  @Inject
  public GameManager(final Provider<Game> gameProvider, @MaxGames final Integer maxGames) {
    this.gameProvider = gameProvider;
    this.maxGames = maxGames;
  }

  /**
   * Creates a new game, if there are free game slots. Returns null if there are already the maximum
   * number of games in progress.
   * 
   * @return Newly created game, or {@code null} if the maximum number of games are in progress.
   */
  public Game createGame() {
    synchronized (games) {
      if (games.size() >= maxGames) {
        return null;
      }
      final Game game = gameProvider.get();
      assert (game.getId() >= 0);
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
    }
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
