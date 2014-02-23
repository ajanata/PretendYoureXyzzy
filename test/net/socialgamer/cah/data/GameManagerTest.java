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

import static org.easymock.EasyMock.anyObject;
import static org.easymock.EasyMock.createMock;
import static org.easymock.EasyMock.eq;
import static org.easymock.EasyMock.expectLastCall;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.util.Collection;
import java.util.HashMap;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.atomic.AtomicInteger;

import net.socialgamer.cah.HibernateUtil;
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.data.GameManager.MaxGames;
import net.socialgamer.cah.data.QueuedMessage.MessageType;

import org.hibernate.Session;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Provides;


/**
 * Tests for {@code GameManager}.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class GameManagerTest {

  private Injector injector;
  private GameManager gameManager;
  private ConnectedUsers cuMock;
  private User userMock;
  private int gameId;
  private final ScheduledThreadPoolExecutor timer = new ScheduledThreadPoolExecutor(1);

  @Before
  public void setUp() throws Exception {
    cuMock = createMock(ConnectedUsers.class);
    userMock = createMock(User.class);

    injector = Guice.createInjector(new AbstractModule() {
      @Override
      protected void configure() {
        bind(ConnectedUsers.class).toInstance(cuMock);

        final ScheduledThreadPoolExecutor threadPool =
            new ScheduledThreadPoolExecutor(1,
                new ThreadFactory() {
                  final AtomicInteger threadCount = new AtomicInteger();

                  @Override
                  public Thread newThread(final Runnable r) {
                    final Thread t = new Thread(r);
                    t.setDaemon(true);
                    t.setName("timer-task-" + threadCount.incrementAndGet());
                    return t;
                  }
                });
        bind(ScheduledThreadPoolExecutor.class).toInstance(threadPool);
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

      @SuppressWarnings("unused")
      @Provides
      Session provideSession() {
        return HibernateUtil.instance.sessionFactory.openSession();
      }
    });

    gameManager = injector.getInstance(GameManager.class);
  }

  @After
  public void tearDown() {
    verify(cuMock);
    verify(userMock);
  }

  @SuppressWarnings("unchecked")
  @Test
  public void testGetAndDestroyGame() {
    cuMock.broadcastToAll(eq(MessageType.GAME_EVENT), anyObject(HashMap.class));
    expectLastCall().times(3);
    replay(cuMock);
    replay(userMock);

    // fill it up with 3 games
    assertEquals(0, gameManager.get().intValue());
    gameManager.getGames().put(0, new Game(0, cuMock, gameManager, timer, null));
    assertEquals(1, gameManager.get().intValue());
    gameManager.getGames().put(1, new Game(1, cuMock, gameManager, timer, null));
    assertEquals(2, gameManager.get().intValue());
    gameManager.getGames().put(2, new Game(2, cuMock, gameManager, timer, null));
    // make sure it says it can't make any more
    assertEquals(-1, gameManager.get().intValue());

    // remove game 1 using its own method -- this should be how it always happens in production
    gameManager.destroyGame(1);
    // make sure it re-uses that id
    assertEquals(1, gameManager.get().intValue());
    gameManager.getGames().put(1, new Game(1, cuMock, gameManager, timer, null));
    assertEquals(-1, gameManager.get().intValue());

    // remove game 1 out from under it, to make sure it'll fix itself
    gameManager.getGames().remove(1);
    assertEquals(1, gameManager.get().intValue());
    gameManager.getGames().put(1, new Game(1, cuMock, gameManager, timer, null));
    assertEquals(-1, gameManager.get().intValue());

    gameManager.destroyGame(2);
    gameManager.destroyGame(0);
    assertEquals(2, gameManager.get().intValue());
  }

  @SuppressWarnings("unchecked")
  @Test
  public void testCreateGame() {
    cuMock.broadcastToAll(eq(MessageType.GAME_EVENT), anyObject(HashMap.class));
    expectLastCall().times(3);
    cuMock.broadcastToList(anyObject(Collection.class), eq(MessageType.GAME_PLAYER_EVENT),
        anyObject(HashMap.class));
    expectLastCall().times(3);
    replay(cuMock);

    userMock.joinGame(anyObject(Game.class));
    expectLastCall().times(3);
    userMock.getNickname();
    expectLastCall().andReturn("test").times(3);
    replay(userMock);

    Game game = gameManager.createGameWithPlayer(userMock);
    assertNotNull(game);
    gameId = 1;
    game = gameManager.createGameWithPlayer(userMock);
    assertNotNull(game);
    gameId = 2;
    game = gameManager.createGameWithPlayer(userMock);
    assertNotNull(game);
    gameId = -1;
    game = gameManager.createGameWithPlayer(userMock);
    assertNull(game);
  }
}
