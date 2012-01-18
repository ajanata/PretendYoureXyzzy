package net.socialgamer.cah.data;

import static org.easymock.EasyMock.createMock;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.data.GameManager.MaxGames;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Provides;


public class GameManagerTest {

  private Injector injector;
  private GameManager gameManager;
  private ConnectedUsers cmMock;
  private int gameId;

  @Before
  public void setUp() throws Exception {
    injector = Guice.createInjector(new AbstractModule() {
      @Override
      protected void configure() {
        // pass
      }

      @SuppressWarnings("unused")
      @Provides
      @MaxGames
      Integer provideMaxGames() {
        return 3;
      }

      @SuppressWarnings("unused")
      @Provides
      @GameId
      Integer provideGameId() {
        return gameId;
      }
    });

    gameManager = injector.getInstance(GameManager.class);
    cmMock = createMock(ConnectedUsers.class);
    replay(cmMock);
  }

  @After
  public void tearDown() {
    verify(cmMock);
  }

  @Test
  public void testGetAndDestroyGame() {
    // fill it up with 3 games
    assertEquals(0, gameManager.get().intValue());
    gameManager.getGames().put(0, new Game(0, cmMock));
    assertEquals(1, gameManager.get().intValue());
    gameManager.getGames().put(1, new Game(1, cmMock));
    assertEquals(2, gameManager.get().intValue());
    gameManager.getGames().put(2, new Game(2, cmMock));
    // make sure it says it can't make any more
    assertEquals(-1, gameManager.get().intValue());

    // remove game 1 using its own method -- this should be how it always happens in production
    gameManager.destroyGame(1);
    // make sure it re-uses that id
    assertEquals(1, gameManager.get().intValue());
    gameManager.getGames().put(1, new Game(1, cmMock));
    assertEquals(-1, gameManager.get().intValue());

    // remove game 1 out from under it, to make sure it'll fix itself
    gameManager.getGames().remove(1);
    assertEquals(1, gameManager.get().intValue());
    gameManager.getGames().put(1, new Game(1, cmMock));
    assertEquals(-1, gameManager.get().intValue());

    gameManager.destroyGame(2);
    gameManager.destroyGame(0);
    assertEquals(2, gameManager.get().intValue());
  }

  @Test
  public void testCreateGame() {
    Game game = gameManager.createGame();
    assertNotNull(game);
    gameId = 1;
    game = gameManager.createGame();
    assertNotNull(game);
    gameId = 2;
    game = gameManager.createGame();
    assertNotNull(game);
    gameId = -1;
    game = gameManager.createGame();
    assertNull(game);
  }
}
