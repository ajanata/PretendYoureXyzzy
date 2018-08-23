package net.socialgamer.cah.serveralive;

import org.jetbrains.annotations.Nullable;

import java.math.BigInteger;

/**
 * @author Gianlu
 */
public class ServerAliveConnectionHolder {
  private static ServerAliveConnectionHolder instance;
  private final Shannon recvShannon;

  private ServerAliveConnectionHolder(byte[] sharedKey) {
    recvShannon = new Shannon();
    recvShannon.key(sharedKey);
  }

  public static void init(byte[] sharedKey) {
    instance = new ServerAliveConnectionHolder(sharedKey);
  }

  @Nullable
  public static ServerAliveConnectionHolder get() {
    return instance;
  }

  public void decrypt(BigInteger nonce, byte[] buffer) {
    recvShannon.nonce(nonce.toByteArray());
    recvShannon.decrypt(buffer);
  }

  @Override
  public String toString() {
    return "ServerAliveConnectionHolder{" +
            "recvShannon=" + recvShannon + '}';
  }
}
