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

import javax.annotation.Nullable;

import com.maxmind.geoip2.model.CityResponse;

import net.socialgamer.cah.data.BlackCard;
import net.socialgamer.cah.data.CardSet;
import net.socialgamer.cah.data.WhiteCard;


/**
 * Collect metrics about card plays, and correlate them with (anonymized) user data.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public interface Metrics {
  void shutdown();

  void serverStart(String startupId);

  void userConnect(String persistentId, String sessionId, @Nullable CityResponse geoIp,
      String agentName, String agentType, String agentOs, String agentLanguage);

  void userDisconnect(String sessionId);

  // The card data is way too complicated to dictate the format it should be in, so let
  // implementations deal with the structured data.
  void roundComplete(String gameId, String roundId, String judgeSessionId, String winnerSessionId,
      BlackCard blackCard, Map<String, List<WhiteCard>> cards);

  void gameStart(String gameId, Collection<CardSet> decks, int blanks, int maxPlayers,
      int scoreGoal, boolean hasPassword);

  void cardDealt(String gameId, String sessionId, WhiteCard card, long dealSeq);
}
