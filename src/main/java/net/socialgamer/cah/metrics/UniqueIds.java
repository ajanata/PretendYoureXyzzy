/**
 * Copyright (c) 2017, Andy Janata
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

package net.socialgamer.cah.metrics;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicLong;

import net.socialgamer.cah.CahModule.ServerStarted;

import org.apache.log4j.Logger;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;


/**
 * <p>A provider for server-wide unique IDs, which will not conflict with another server or if this
 * server restarts.</p>
 * <p>Unique IDs are composed of the following elements, separated by underscores:
 * <ul><li>server hostname (or a random UUID if the hostname cannot be determined)</li>
 * <li>the number of milliseconds since the UNIX epoch at the time the server was started</li>
 * <li>a long interger that strictly increases each time an ID is requested</li></ul></p>
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
@Singleton
public class UniqueIds implements Provider<String> {

  private static final Logger LOG = Logger.getLogger(UniqueIds.class);

  private static final String hostname;

  private final AtomicLong counter = new AtomicLong(0);
  private final Date serverStarted;

  static {
    String hn;
    try {
      hn = InetAddress.getLocalHost().getHostName();
    } catch (final UnknownHostException e) {
      hn = UUID.randomUUID().toString();
      LOG.warn(String.format("Unable to determine hostname, using %s instead.", hn));
    }
    hostname = hn;
  }

  @Inject
  public UniqueIds(@ServerStarted final Date serverStarted) {
    this.serverStarted = serverStarted;
  }

  @Override
  public String get() {
    // hostname_started_seq
    return String.format("%s_%d_%d", hostname, serverStarted.getTime(), counter.getAndIncrement());
  }
}
