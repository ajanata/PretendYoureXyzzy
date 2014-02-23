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

import static org.easymock.EasyMock.anyInt;
import static org.easymock.EasyMock.anyObject;
import static org.easymock.EasyMock.createMock;
import static org.easymock.EasyMock.eq;
import static org.easymock.EasyMock.expectLastCall;
import static org.easymock.EasyMock.replay;
import static org.easymock.EasyMock.verify;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.Collection;
import java.util.HashMap;
import java.util.concurrent.ScheduledThreadPoolExecutor;

import net.socialgamer.cah.data.Game.TooManyPlayersException;
import net.socialgamer.cah.data.QueuedMessage.MessageType;

import org.junit.Before;
import org.junit.Test;


/**
 * Tests for {@code Game}.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class GameTest {

  private Game game;
  private ConnectedUsers cuMock;
  private GameManager gmMock;
  private final ScheduledThreadPoolExecutor timer = new ScheduledThreadPoolExecutor(1);

  @Before
  public void setUp() throws Exception {
    cuMock = createMock(ConnectedUsers.class);
    gmMock = createMock(GameManager.class);
    game = new Game(0, cuMock, gmMock, timer, null);
  }

  @SuppressWarnings("unchecked")
  @Test
  public void testRemovePlayer() throws IllegalStateException, TooManyPlayersException {
    cuMock.broadcastToList(anyObject(Collection.class), eq(MessageType.GAME_PLAYER_EVENT),
        anyObject(HashMap.class));
    expectLastCall().times(4);
    replay(cuMock);
    gmMock.destroyGame(anyInt());
    expectLastCall().once();
    replay(gmMock);

    final User user1 = new User("test1", "test.lan", false);
    final User user2 = new User("test2", "test.lan", false);
    game.addPlayer(user1);
    game.addPlayer(user2);

    assertEquals(user1, game.getHost());
    assertFalse(game.removePlayer(user1));
    assertEquals(user2, game.getHost());
    assertTrue(game.removePlayer(user2));
    assertEquals(null, game.getHost());

    verify(cuMock);
    verify(gmMock);
  }
}
