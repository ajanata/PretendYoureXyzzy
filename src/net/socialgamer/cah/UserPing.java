/**
 * Copyright (c) 2012, Andy Janata
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

package net.socialgamer.cah;

import java.util.concurrent.ScheduledThreadPoolExecutor;

import net.socialgamer.cah.data.ConnectedUsers;

import com.google.inject.Inject;


/**
 * Timer task to check for disconnected and idle clients.
 * 
 * @author Andy Janata (ajanata@gmail.com)
 */
public class UserPing extends SafeTimerTask {

  private final ConnectedUsers users;
  private final ScheduledThreadPoolExecutor globalTimer;

  @Inject
  public UserPing(final ConnectedUsers users, final ScheduledThreadPoolExecutor globalTimer) {
    this.users = users;
    this.globalTimer = globalTimer;
  }

  @Override
  public void process() {
    users.checkForPingAndIdleTimeouts();
    globalTimer.purge();
  }
}
