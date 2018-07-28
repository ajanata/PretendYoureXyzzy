/**
 * Copyright (c) 2012-2018, Andy Janata
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

import org.hibernate.Session;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Provider;
import com.google.inject.Provides;

import net.socialgamer.cah.CahModule.AllowBlankCards;
import net.socialgamer.cah.CahModule.GamePermalinkUrlFormat;
import net.socialgamer.cah.CahModule.RoundPermalinkUrlFormat;
import net.socialgamer.cah.CahModule.ShowGamePermalink;
import net.socialgamer.cah.CahModule.ShowRoundPermalink;
import net.socialgamer.cah.CahModule.UniqueId;
import net.socialgamer.cah.HibernateUtil;
import net.socialgamer.cah.cardcast.CardcastModule.CardcastCardId;
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.data.GameManager.MaxGames;
import net.socialgamer.cah.data.QueuedMessage.MessageType;
import net.socialgamer.cah.metrics.Metrics;
import net.socialgamer.cah.metrics.NoOpMetrics;


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
  private Metrics metricsMock;
  private final Provider<Boolean> falseProvider = new Provider<Boolean>() {
    @Override
    public Boolean get() {
      return Boolean.FALSE;
    }
  };
  private final Provider<String> formatProvider = new Provider<String>() {
    @Override
    public String get() {
      return "%s";
    }
  };

  @Before
  public void setUp() throws Exception {
    cuMock = createMock(ConnectedUsers.class);
    userMock = createMock(User.class);
    metricsMock = createMock(Metrics.class);

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
        bind(Metrics.class).to(NoOpMetrics.class);
        bind(Boolean.class).annotatedWith(ShowRoundPermalink.class).toProvider(falseProvider);
        bind(String.class).annotatedWith(RoundPermalinkUrlFormat.class).toProvider(formatProvider);
        bind(Boolean.class).annotatedWith(ShowGamePermalink.class).toProvider(falseProvider);
        bind(String.class).annotatedWith(GamePermalinkUrlFormat.class).toProvider(formatProvider);
        bind(Boolean.class).annotatedWith(AllowBlankCards.class).toProvider(falseProvider);
      }

      @Provides
      @MaxGames
      Integer provideMaxGames() {
        return 3;
      }

      @Provides
      @GameId
      Integer provideGameId() {
        return gameId;
      }

      @Provides
      Session provideSession() {
        return HibernateUtil.instance.sessionFactory.openSession();
      }

      @Provides
      @CardcastCardId
      Integer provideCardcastCardId() {
        return 0;
      }

      @Provides
      @UniqueId
      String provideUniqueId() {
        return "1";
      }
    });

    gameManager = injector.getInstance(GameManager.class);
  }

  @After
  public void tearDown() {
    verify(cuMock);
    verify(userMock);
  }

  @Test
  public void testGetAndDestroyGame() {
    replay(cuMock);
    replay(userMock);

    // fill it up with 3 games
    assertEquals(0, gameManager.get().intValue());
    gameManager.getGames().put(0,
        new Game(0, cuMock, gameManager, timer, null, null, null, metricsMock, falseProvider,
            formatProvider, falseProvider, formatProvider, falseProvider));
    assertEquals(1, gameManager.get().intValue());
    gameManager.getGames().put(1,
        new Game(1, cuMock, gameManager, timer, null, null, null, metricsMock, falseProvider,
            formatProvider, falseProvider, formatProvider, falseProvider));
    assertEquals(2, gameManager.get().intValue());
    gameManager.getGames().put(2,
        new Game(2, cuMock, gameManager, timer, null, null, null, metricsMock, falseProvider,
            formatProvider, falseProvider, formatProvider, falseProvider));
    // make sure it says it can't make any more
    assertEquals(-1, gameManager.get().intValue());

    // remove game 1 using its own method -- this should be how it always happens in production
    gameManager.destroyGame(1);
    // make sure it re-uses that id
    assertEquals(1, gameManager.get().intValue());
    gameManager.getGames().put(1,
        new Game(1, cuMock, gameManager, timer, null, null, null, metricsMock, falseProvider,
            formatProvider, falseProvider, formatProvider, falseProvider));
    assertEquals(-1, gameManager.get().intValue());

    // remove game 1 out from under it, to make sure it'll fix itself
    gameManager.getGames().remove(1);
    assertEquals(1, gameManager.get().intValue());
    gameManager.getGames().put(1,
        new Game(1, cuMock, gameManager, timer, null, null, null, metricsMock, falseProvider,
            formatProvider, falseProvider, formatProvider, falseProvider));
    assertEquals(-1, gameManager.get().intValue());

    gameManager.destroyGame(2);
    gameManager.destroyGame(0);
    assertEquals(2, gameManager.get().intValue());
  }

  @SuppressWarnings("unchecked")
  @Test
  public void testCreateGame() {
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
