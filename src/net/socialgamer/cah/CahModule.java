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

import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.data.GameManager.MaxGames;

import org.hibernate.Session;

import com.google.inject.AbstractModule;
import com.google.inject.Provides;


/**
 * CAH Guice module.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class CahModule extends AbstractModule {

  @Override
  protected void configure() {
    bind(Integer.class).annotatedWith(GameId.class).toProvider(GameManager.class);
  }

  /**
   * TODO Provide a configuration option for this instead of hard-coding it.
   * 
   * @return The maximum number of games allowed on this server.
   */
  @Provides
  @MaxGames
  Integer provideMaxGames() {
    return 30;
  }

  /**
   * @return A Hibernate session. Objects which receive a Hibernate session should close the
   * session when they are done!
   */
  @Provides
  Session provideHibernateSession() {
    return HibernateUtil.instance.sessionFactory.openSession();
  }
}
