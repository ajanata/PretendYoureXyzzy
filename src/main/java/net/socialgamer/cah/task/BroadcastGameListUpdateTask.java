package net.socialgamer.cah.task;

import java.util.HashMap;

import net.socialgamer.cah.Constants.LongPollEvent;
import net.socialgamer.cah.Constants.LongPollResponse;
import net.socialgamer.cah.Constants.ReturnableData;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.QueuedMessage.MessageType;

import com.google.inject.Inject;
import com.google.inject.Singleton;


@Singleton
public class BroadcastGameListUpdateTask extends SafeTimerTask {

  private volatile boolean needsUpdate = false;
  private final ConnectedUsers users;

  @Inject
  public BroadcastGameListUpdateTask(final ConnectedUsers users) {
    this.users = users;
  }

  public void needsUpdate() {
    needsUpdate = true;
  }

  @Override
  public void process() {
    if (needsUpdate) {
      final HashMap<ReturnableData, Object> broadcastData = new HashMap<ReturnableData, Object>();
      broadcastData.put(LongPollResponse.EVENT, LongPollEvent.GAME_LIST_REFRESH.toString());
      users.broadcastToAll(MessageType.GAME_EVENT, broadcastData);
      needsUpdate = false;
    }
  }
}
