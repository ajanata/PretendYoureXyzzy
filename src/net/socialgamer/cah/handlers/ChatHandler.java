package net.socialgamer.cah.handlers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.socialgamer.cah.Server;
import net.socialgamer.cah.data.ConnectedUsers;
import net.socialgamer.cah.data.QueuedMessage.Type;
import net.socialgamer.cah.data.User;

import com.google.inject.Inject;


public class ChatHandler extends Handler {

  public static final String OP = "chat";

  private final ConnectedUsers users;

  @Inject
  public ChatHandler(final Server server) {
    this.users = server.getConnectedUsers();
  }

  @Override
  public Map<String, Object> handle(final Map<String, String[]> parameters,
      final HttpSession session) {
    final Map<String, Object> data = new HashMap<String, Object>();

    final User user = (User) session.getAttribute("user");
    assert (user != null);

    if (!parameters.containsKey("message") || parameters.get("message").length != 1) {
      return error("No message specified.");
    } else {
      final String message = parameters.get("message")[0].trim();
      if (message.length() > 200) {
        return error("Messages cannot be longer than 200 characters.");
      } else {
        final HashMap<String, Object> broadcastData = new HashMap<String, Object>();
        broadcastData.put("event", "chat");
        broadcastData.put("from", user.getNickname());
        broadcastData.put("message", message);
        // TODO once there are multiple chat channels, put the destination here
        // TODO once there are games and they have their own chat, make it only send to participants
        users.broadcastToAll(Type.CHAT, broadcastData);
      }
    }

    return data;
  }
}
