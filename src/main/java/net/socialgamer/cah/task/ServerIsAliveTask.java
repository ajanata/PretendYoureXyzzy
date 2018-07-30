package net.socialgamer.cah.task;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;
import net.socialgamer.cah.CahModule;
import org.apache.log4j.Logger;
import org.json.JSONObject;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;

/**
 * @author Gianlu
 */
@Singleton
public class ServerIsAliveTask extends SafeTimerTask {
  private static final URL GET_MY_IP;
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
  private final Provider<Boolean> discoverySecureProvider;
  private String host = null;
  private int port = -1;
  private boolean secure = false;

  @Inject
  public ServerIsAliveTask(@CahModule.ServerDiscoveryAddress Provider<String> discoveryAddressProvider,
                           @CahModule.ServerDiscoveryPort Provider<Integer> discoveryPortProvider,
                           @CahModule.ServerDiscoverySecure Provider<Boolean> discoverySecureProvider) {
    this.discoveryAddressProvider = discoveryAddressProvider;
    this.discoveryPortProvider = discoveryPortProvider;
    this.discoverySecureProvider = discoverySecureProvider;
  }

  @Override
  public void process() {
    if (host == null || port == -1) {
      Integer discoveryPort = discoveryPortProvider.get();
      if (discoveryPort == null || discoveryPort <= 0 || discoveryPort >= 65536)
        throw new IllegalArgumentException("Invalid server discovery configuration!");

      String discoveryAddress = discoveryAddressProvider.get();
      if (discoveryAddress != null && !discoveryAddress.isEmpty()) {
        host = discoveryAddress;
        port = discoveryPort;
        secure = discoverySecureProvider.get();
      } else {
        try {
          HttpURLConnection conn = (HttpURLConnection) GET_MY_IP.openConnection();
          conn.connect();

          try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            JSONObject obj = new JSONObject(reader.readLine());
            host = obj.getString("ip");
            port = discoveryPortProvider.get();
            logger.info("Successfully retrieved server IP: " + host);
          }

          conn.disconnect();
        } catch (IOException ex) {
          logger.error("Failed retrieving server IP!", ex);
        }
      }
    }

    try {
      URI uri = new URI("http", "localhost", "/AmAlive", null);

      JSONObject req = new JSONObject();
      req.put("host", host)
              .put("port", port)
              .put("secure", secure);

      HttpURLConnection conn = (HttpURLConnection) uri.toURL().openConnection();
      conn.setRequestMethod("POST");
      conn.setDoOutput(true);
      conn.connect();

      try (BufferedOutputStream out = new BufferedOutputStream(conn.getOutputStream())) {
        String json = req.toString();
        out.write(json.getBytes());
        out.flush();
      }

      try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
        JSONObject resp = new JSONObject(reader.readLine());
        if (resp.has("error")) {
          logger.error("Failed registering to the discovery API: " + resp.get("error"));
        } else {
          System.out.println(reader);  // TODO
        }
      }

      conn.disconnect();
    } catch (IOException | URISyntaxException ex) {
      logger.error("Failed contacting server discovery API!", ex);
    }
  }
}
