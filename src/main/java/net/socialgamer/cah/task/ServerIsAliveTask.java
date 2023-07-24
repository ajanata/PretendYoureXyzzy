package net.socialgamer.cah.task;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;
import net.socialgamer.cah.CahModule;
import net.socialgamer.cah.serveralive.DiffieHellman;
import net.socialgamer.cah.serveralive.ServerAliveConnectionHolder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

/**
 * @author Gianlu
 */
@Singleton
public class ServerIsAliveTask extends SafeTimerTask {
  private static final URL GET_MY_IP;
  private static final Logger LOG = LogManager.getLogger(ServerIsAliveTask.class);
  private static final URL AM_ALIVE_API;

  static {
    try {
      GET_MY_IP = URI.create("https://api.ipify.org?format=json").toURL();
      AM_ALIVE_API = URI.create("http://discovery.pyx.gianlu.xyz/AmAlive").toURL();
    } catch (MalformedURLException ex) {
      throw new RuntimeException(ex);
    }
  }

  private final Provider<String> discoveryAddressProvider;
  private final Provider<Integer> discoveryPortProvider;
  private final Provider<Boolean> discoverySecureProvider;
  private final Provider<String> discoveryMetricsProvider;
  private final Provider<String> discoveryPathProvider;
  private String host = null;
  private int port = -1;
  private boolean secure = false;

  @Inject
  public ServerIsAliveTask(@CahModule.ServerDiscoveryAddress Provider<String> discoveryAddressProvider,
                           @CahModule.ServerDiscoveryPort Provider<Integer> discoveryPortProvider,
                           @CahModule.ServerDiscoverySecure Provider<Boolean> discoverySecureProvider,
                           @CahModule.ServerDiscoveryMetrics Provider<String> discoveryMetricsProvider,
                           @CahModule.ServerDiscoveryPath Provider<String> discoveryPathProvider) {
    this.discoveryAddressProvider = discoveryAddressProvider;
    this.discoveryPortProvider = discoveryPortProvider;
    this.discoverySecureProvider = discoverySecureProvider;
    this.discoveryMetricsProvider = discoveryMetricsProvider;
    this.discoveryPathProvider = discoveryPathProvider;
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
            LOG.info("Successfully retrieved server IP: " + host);
          }

          conn.disconnect();
        } catch (IOException ex) {
          LOG.error("Failed retrieving server IP!", ex);
        }
      }
    }

    try {
      DiffieHellman diffieHellman = new DiffieHellman();
      BigInteger publicKey = diffieHellman.generatePublicKey();

      JSONObject req = new JSONObject();
      req.put("host", host)
              .put("path", discoveryPathProvider.get())
              .put("port", port)
              .put("publicKey", publicKey.toString(16))
              .put("metrics", discoveryMetricsProvider.get())
              .put("secure", secure);

      HttpURLConnection conn = (HttpURLConnection) AM_ALIVE_API.openConnection();
      conn.setRequestMethod("POST");
      conn.setDoOutput(true);

      try (BufferedOutputStream out = new BufferedOutputStream(conn.getOutputStream())) {
        String json = req.toString();
        out.write(json.getBytes());
        out.flush();
      }

      if (conn.getResponseCode() == 200) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
          JSONObject resp = new JSONObject(reader.readLine());
          byte[] sharedKey = diffieHellman.computeSharedKey(new BigInteger(resp.getString("publicKey"), 16));
          ServerAliveConnectionHolder.init(sharedKey);
          LOG.info("Registered to discovery API!");
        }
      } else {
        LOG.error("Failed registering to the discovery API: " + conn.getResponseCode());
      }

      conn.disconnect();
    } catch (IOException | InvalidKeyException | NoSuchAlgorithmException | InvalidAlgorithmParameterException |
             InvalidKeySpecException ex) {
      LOG.error("Failed contacting server discovery API!", ex);
    }
  }
}
