package net.socialgamer.cah.data;

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

import net.socialgamer.cah.data.QueuedMessage.Type;

import org.junit.Before;
import org.junit.Test;


public class GameTest {

  private Game game;
  private ConnectedUsers cmMock;

  @Before
  public void setUp() throws Exception {
    cmMock = createMock(ConnectedUsers.class);
    game = new Game(0, cmMock);
  }

  @SuppressWarnings("unchecked")
  @Test
  public void testRemovePlayer() {
    cmMock.broadcastToList(anyObject(Collection.class), eq(Type.GAME_PLAYER_EVENT),
        anyObject(HashMap.class));
    expectLastCall().times(4);
    replay(cmMock);

    final User user1 = new User("test1");
    final User user2 = new User("test2");
    game.addPlayer(user1);
    game.addPlayer(user2);

    assertEquals(user1, game.getHost());
    assertFalse(game.removePlayer(user1));
    assertEquals(user2, game.getHost());
    assertTrue(game.removePlayer(user2));
    assertEquals(null, game.getHost());

    verify(cmMock);

  }
}
