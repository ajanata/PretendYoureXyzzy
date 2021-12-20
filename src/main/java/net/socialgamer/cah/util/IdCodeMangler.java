/**
 * Copyright (c) 2018, Andy Janata
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

package net.socialgamer.cah.util;

import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.inject.Inject;

import net.socialgamer.cah.CahModule.IdCodeSalt;


public class IdCodeMangler {
  private static final Logger LOG = LogManager.getLogger(IdCodeMangler.class);

  private final String salt;
  private final Base64.Encoder encoder = Base64.getEncoder();

  @Inject
  public IdCodeMangler(@IdCodeSalt final String salt) {
    this.salt = salt;
  }

  public String mangle(final String username, final String idCode) {
    if (null == idCode || idCode.trim().isEmpty()) {
      return "";
    }
    try {
      final MessageDigest md = MessageDigest.getInstance("SHA-256");
      final byte[] plaintext = (salt + username + idCode.trim()).getBytes(Charset.forName("UTF-8"));
      // 32 byte output
      final byte[] digest = md.digest(plaintext);
      final byte[] condensed = new byte[8];
      for (int i = 0; i < 8; i++) {
        condensed[i] = (byte) (digest[i] ^ digest[i + 8] ^ digest[i + 16] ^ digest[i + 24]);
      }
      return encoder.encodeToString(condensed).substring(0, 11);
    } catch (final NoSuchAlgorithmException e) {
      LOG.error("Unable to mangle ID code.", e);
      return "";
    }
  }
}
