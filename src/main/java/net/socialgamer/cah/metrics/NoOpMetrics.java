/**
 * Copyright (c) 2017-2018, Andy Janata
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

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.inject.Singleton;
import com.maxmind.geoip2.model.CityResponse;

import net.socialgamer.cah.data.BlackCard;
import net.socialgamer.cah.data.CardSet;
import net.socialgamer.cah.data.WhiteCard;


/**
 * A no-op metrics implementation. All data are logged at TRACE then discarded.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
@Singleton
public class NoOpMetrics implements Metrics {

  private static final Logger LOG = LogManager.getLogger(NoOpMetrics.class);

  @Override
  public void shutdown() {
    // nothing to do
  }

  @Override
  public void serverStart(final String startupId) {
    LOG.trace(String.format("serverStarted(%s)", startupId));
  }

  @Override
  public void userConnect(final String persistentId, final String sessionId, final CityResponse geoIp,
      final String agentName, final String agentType, final String agentOs,
      final String agentLanguage) {
    LOG.trace(String.format("newUser(%s, %s, %s, %s, %s, %s, %s)", persistentId, sessionId, geoIp,
        agentName, agentType, agentOs, agentLanguage));
  }

  @Override
  public void userDisconnect(final String sessionId) {
    LOG.trace(String.format("userDisconnect(%s)", sessionId));
  }

  @Override
  public void gameStart(final String gameId, final Collection<CardSet> decks, final int blanks,
      final int maxPlayers, final int scoreGoal, final boolean hasPassword) {
    LOG.trace(String.format("gameStart(%s, %s, %d, %d, %d, %s)", gameId, decks.toArray(), blanks,
        maxPlayers, scoreGoal, hasPassword));
  }

  @Override
  public void roundComplete(final String gameId, final String roundId, final String judgeSessionId,
      final String winnerSessionId, final BlackCard blackCard,
      final Map<String, List<WhiteCard>> cards) {
    LOG.trace(String.format("roundJudged(%s, %s, %s, %s, %s, %s)", gameId, roundId, judgeSessionId,
        winnerSessionId, blackCard, cards));
  }

  @Override
  public void cardDealt(final String gameId, final String sessionId, final WhiteCard card,
      final long dealSeq) {
    LOG.trace(String.format("cardDealt(%s, %s, %s, %d)", gameId, sessionId, card, dealSeq));
  }
}
