/**
 * Copyright (c) 2012, Andy Janata
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 *   and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 *   conditions and the following disclaimer in the documentation and/or other materials provided
 *   with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package net.socialgamer.cah.data;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.common.annotations.VisibleForTesting;
import com.google.inject.BindingAnnotation;
import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;

import net.socialgamer.cah.data.Game.TooManyPlayersException;
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.task.BroadcastGameListUpdateTask;


/**
 * Manage games for the server.
 *
 * This is also a Guice provider for game ids.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
@Singleton
@GameId
public class GameManager implements Provider<Integer> {
  private static final Logger logger = LogManager.getLogger(GameManager.class);

  private final Provider<Integer> maxGamesProvider;
  private final Map<Integer, Game> games = new TreeMap<Integer, Game>();
  private final Provider<Game> gameProvider;
  private final BroadcastGameListUpdateTask broadcastUpdate;

  /**
   * Potential next game id.
   */
  private int nextId = 0;

  /**
   * Create a new game manager.
   *
   * @param gameProvider
   *          Provider for new {@code Game} instances.
   * @param maxGamesProvider
   *          Provider for maximum number of games allowed on the server.
   * @param users
   *          Connected user manager.
   */
  @Inject
  public GameManager(final Provider<Game> gameProvider,
      @MaxGames final Provider<Integer> maxGamesProvider,
      final BroadcastGameListUpdateTask broadcastUpdate) {
    this.gameProvider = gameProvider;
    this.maxGamesProvider = maxGamesProvider;
    this.broadcastUpdate = broadcastUpdate;
  }

  private int getMaxGames() {
    return maxGamesProvider.get();
  }

  /**
   * Creates a new game, if there are free game slots. Returns {@code null} if there are already the
   * maximum number of games in progress.
   *
   * @return Newly created game, or {@code null} if the maximum number of games are in progress.
   */
  private Game createGame() {
    synchronized (games) {
      if (games.size() >= getMaxGames()) {
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
   * Returns {@code null} if there are already the maximum number of games in progress.
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
        logger.info(String.format("Created new game %d by user %s.",
            game.getId(), user.toString()));
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
   *
   * @param gameId
   *          ID of game to destroy.
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
      // remove the players from the game
      final List<User> usersToRemove = game.getUsers();
      for (final User user : usersToRemove) {
        game.removePlayer(user);
        game.removeSpectator(user);
      }

      logger.info(String.format("Destroyed game %d.", game.getId()));
      broadcastGameListRefresh();
    }
  }

  /**
   * Broadcast an event to all users that they should refresh the game list.
   */
  public void broadcastGameListRefresh() {
    broadcastUpdate.needsUpdate();
  }

  /**
   * Get an unused game ID, or -1 if the maximum number of games are in progress. This should not be
   * called in such a case, though!
   *
   * TODO: make this not suck
   *
   * @return Next game id, or {@code -1} if the maximum number of games are in progress.
   */
  @Override
  public Integer get() {
    synchronized (games) {
      if (games.size() >= getMaxGames()) {
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

  /**
   * Try to guess a good candidate for the next game id.
   *
   * @param skip
   *          An id to skip over.
   * @return A guess for the next game id.
   */
  private int candidateGameId(final int skip) {
    synchronized (games) {
      final int maxGames = getMaxGames();
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

  /**
   * @return A copy of the list of all current games.
   */
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

  @VisibleForTesting
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
