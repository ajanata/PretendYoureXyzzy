package net.socialgamer.cah.data;

import com.sun.istack.internal.NotNull;

import javax.annotation.Nullable;
import java.util.concurrent.atomic.AtomicReference;

/**
 * @author Gianlu
 */
public class ServerIsAliveTokenHolder {
  private static final AtomicReference<String> token = new AtomicReference<>(null);

  private ServerIsAliveTokenHolder() {
  }

  @Nullable
  public static String get() {
    synchronized (token) {
      return token.get();
    }
  }

  public static void set(@NotNull String set) {
    synchronized (token) {
      token.set(set);
    }
  }
}
