package net.socialgamer.cah.task;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;
import net.socialgamer.cah.CahModule;
import net.socialgamer.cah.data.ServerIsAliveTokenHolder;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;

/**
 * @author Gianlu
 */
@Singleton
public class ServerIsAliveTask extends SafeTimerTask {
  private static final URL GET_MY_IP;
  private static final String AM_ALIVE_API = "https://script.google.com/macros/s/AKfycbxaWVr4sEiivlmw_0WqNaYXyMwkZGoarBXcQ7HfZ3tJ53WFqogG/exec?op=amAlive&ip=";
  private static final Logger logger = Logger.getLogger(ServerIsAliveTask.class);

  static {
    try {
      GET_MY_IP = URI.create("https://api.ipify.org?format=json").toURL();
    } catch (MalformedURLException ex) {
      throw new RuntimeException(ex);
    }
  }

  private final Provider<String> discoveryAddressProvider;
  private final Provider<Integer> discoveryPortProvider;
  private String myIp = null;

  @Inject
  public ServerIsAliveTask(@CahModule.ServerDiscoveryAddress Provider<String> discoveryAddressProvider,
                           @CahModule.ServerDiscoveryPort Provider<Integer> discoveryPortProvider) {
    this.discoveryAddressProvider = discoveryAddressProvider;
    this.discoveryPortProvider = discoveryPortProvider;
  }

  @Override
  public void process() {
    if (myIp == null) {
      Integer discoveryPort = discoveryPortProvider.get();
      if (discoveryPort == null || discoveryPort <= 0 || discoveryPort >= 65536)
        throw new IllegalArgumentException("Invalid server discovery configuration!");

      String discoveryAddress = discoveryAddressProvider.get();
      if (discoveryAddress != null && !discoveryAddress.isEmpty()) {
        myIp = discoveryAddress + ":" + discoveryPort;
      } else {
        try {
          HttpURLConnection conn = (HttpURLConnection) GET_MY_IP.openConnection();
          conn.connect();

          try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            JSONObject obj = (JSONObject) JSONValue.parse(reader.readLine());
            myIp = obj.get("ip") + ":" + discoveryPortProvider.get();
            logger.info("Successfully retrieved server IP: " + myIp);
          }

          conn.disconnect();
        } catch (IOException ex) {
          logger.error("Failed retrieving server IP!", ex);
        }
      }
    }

    try {
      HttpURLConnection conn = (HttpURLConnection) URI.create(AM_ALIVE_API + myIp).toURL().openConnection();
      conn.connect();

      try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
        JSONObject obj = (JSONObject) JSONValue.parse(reader.readLine());
        if (obj.containsKey("error")) {
          logger.error("Failed registering to the discovery API: " + obj.get("error"));
        } else {
          String token = (String) obj.get("token");
          ServerIsAliveTokenHolder.set(token);
          logger.info("Registered successfully to the discovery API with token " + token);
        }
      }

      conn.disconnect();
    } catch (IOException ex) {
      logger.error("Failed contacting server discovery API!", ex);
    }
  }
}
