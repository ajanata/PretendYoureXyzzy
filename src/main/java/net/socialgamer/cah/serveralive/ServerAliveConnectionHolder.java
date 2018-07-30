package net.socialgamer.cah.serveralive;

import javax.annotation.Nullable;
import java.math.BigInteger;

/**
 * @author Gianlu
 */
public class ServerAliveConnectionHolder {
  private static ServerAliveConnectionHolder instance;
  private final Shannon recvShannon;
  private BigInteger recvNonce;

  private ServerAliveConnectionHolder(byte[] sharedKey) {
    recvShannon = new Shannon();
    recvShannon.key(sharedKey);

    recvNonce = BigInteger.ZERO;
  }

  public static void init(byte[] sharedKey) {
    instance = new ServerAliveConnectionHolder(sharedKey);
  }

  @Nullable
  public static ServerAliveConnectionHolder get() {
    return instance;
  }

  public void decryptBlock(byte[] buffer, int length) {
    recvShannon.nonce(recvNonce.toByteArray());
    recvShannon.decrypt(buffer, length);
  }

  public void endDecrypt() {
    recvNonce = recvNonce.add(BigInteger.ONE);
  }
}
