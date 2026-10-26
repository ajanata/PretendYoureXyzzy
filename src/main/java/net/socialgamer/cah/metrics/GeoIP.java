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

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;
import com.maxmind.db.CHMCache;
import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.exception.GeoIp2Exception;
import com.maxmind.geoip2.model.CityResponse;


/**
 * Wrapper for GeoLite2.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
@Singleton
public class GeoIP {

  private static final Logger LOG = LogManager.getLogger(GeoIP.class);

  private DatabaseReader reader;
  private boolean initialized = false;

  private final Provider<Properties> propertiesProvider;

  @Inject
  public GeoIP(final Provider<Properties> propertiesProvider) throws IOException {
    this.propertiesProvider = propertiesProvider;
  }

  /**
   * Look up the given IP address in the GeoIP database.
   * @param addr The address to look up.
   * @return Information about the address, or {@code null} if an error occurred or a GeoIP
   * database was not configured.
   */
  public CityResponse getInfo(final InetAddress addr) {
    try {
      final DatabaseReader r = getReader();
      if (null != r) {
        return r.city(addr);
      }
    } catch (IOException | GeoIp2Exception e) {
      // don't include the stack trace, it throws for addresses it doesn't have in its db...
      LOG.error(String.format("Unable to look up %s: %s", addr, e.getMessage()));
    }
    return null;
  }

  private DatabaseReader getReader() {
    if (initialized) {
      return reader;
    }
    return makeReader();
  }

  private synchronized DatabaseReader makeReader() {
    LOG.info("Attempting to create GeoIP database reader");
    initialized = true;
    if (reader != null) {
      return reader;
    }

    final String dbPath = propertiesProvider.get().getProperty("geoip.db");
    if (StringUtils.isNotBlank(dbPath)) {
      final File db = new File(dbPath);
      try {
        reader = new DatabaseReader.Builder(db).withCache(new CHMCache()).build();
      } catch (final IOException e) {
        LOG.error("Unable to create database reader", e);
        reader = null;
      }
    } else {
      reader = null;
    }
    return reader;
  }
}
