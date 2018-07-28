/**
 * Copyright (c) 2012-2018, Andy Janata
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

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.common.collect.ImmutableSet;
import com.google.inject.AbstractModule;
import com.google.inject.BindingAnnotation;
import com.google.inject.Provides;
import com.google.inject.TypeLiteral;
import com.google.inject.assistedinject.FactoryModuleBuilder;

import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.data.GameManager.MaxGames;
import net.socialgamer.cah.data.User;
import net.socialgamer.cah.metrics.Metrics;
import net.socialgamer.cah.metrics.UniqueIds;


/**
 * CAH Guice module.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class CahModule extends AbstractModule {

  private static final Logger LOG = Logger.getLogger(CahModule.class);

  private final Properties properties = new Properties();

  private final ServletContext context;

  public CahModule(final ServletContext context) {
    this.context = context;
  }

  @Override
  protected void configure() {
    bind(Integer.class)
        .annotatedWith(GameId.class)
        .toProvider(GameManager.class);
    /*
     * A mutable Set of IP addresses (in String format) which are banned. This Set is
     * thread-safe.
     */
    bind(new TypeLiteral<Set<String>>() {
    })
        .annotatedWith(BanList.class)
        .toInstance(Collections.synchronizedSet(new HashSet<String>()));

    bind(Properties.class).toInstance(properties);

    // this is only so injected constructors can log
    StartupUtils.reconfigureLogging(context);
    // FIXME huge hack.
    StartupUtils.reloadProperties(context, properties);
    final String metricsClassName = properties.getProperty("pyx.metrics.impl");
    try {
      @SuppressWarnings("unchecked")
      final Class<? extends Metrics> metricsClass = (Class<? extends Metrics>) Class
          .forName(metricsClassName);
      bind(Metrics.class).to(metricsClass);
    } catch (final ClassNotFoundException e) {
      throw new RuntimeException(e);
    }

    bind(Date.class).annotatedWith(ServerStarted.class).toInstance(new Date());
    bind(String.class).annotatedWith(UniqueId.class).toProvider(UniqueIds.class);
    install(new FactoryModuleBuilder().build(User.Factory.class));

    final ScheduledThreadPoolExecutor threadPool =
        new ScheduledThreadPoolExecutor(2 * Runtime.getRuntime().availableProcessors(),
            new ThreadFactory() {
              final AtomicInteger threadCount = new AtomicInteger();

              @Override
              public Thread newThread(final Runnable r) {
                final Thread t = new Thread(r);
                t.setDaemon(true);
                t.setName("timer-task-" + threadCount.incrementAndGet());
                return t;
              }
            });
    threadPool.setRemoveOnCancelPolicy(true);
    bind(ScheduledThreadPoolExecutor.class).toInstance(threadPool);
  }

  @Provides
  @UserPersistentId
  String provideUserPersistentId() {
    return UUID.randomUUID().toString();
  }

  /**
   * @return The maximum number of games allowed on this server.
   */
  @Provides
  @MaxGames
  Integer provideMaxGames() {
    synchronized (properties) {
      return Integer.valueOf(properties.getProperty("pyx.server.max_games", "20"));
    }
  }

  /**
   * @return The maximum number of users allowed to connect to this server.
   */
  @Provides
  @MaxUsers
  Integer provideMaxUsers() {
    synchronized (properties) {
      return Integer.valueOf(properties.getProperty("pyx.server.max_users", "100"));
    }
  }

  @Provides
  @BroadcastConnectsAndDisconnects
  Boolean provideBroadcastConnectsAndDisconnects() {
    synchronized (properties) {
      return Boolean.valueOf(properties.getProperty(
          "pyx.server.broadcast_connects_and_disconnects", "true"));
    }
  }

  @Provides
  @GlobalChatEnabled
  Boolean provideGlobalChatEnabled() {
    synchronized (properties) {
      return Boolean.valueOf(properties.getProperty(
          "pyx.server.global_chat_enabled", "true"));
    }
  }

  @Provides
  @GameChatEnabled
  Boolean provideGameChatEnabled() {
    synchronized (properties) {
      return Boolean.valueOf(properties.getProperty("pyx.server.game_chat_enabled", "true"));
    }
  }

  @Provides
  @ShowGamePermalink
  Boolean provideShowGamePermalink() {
    synchronized (properties) {
      return Boolean.valueOf(properties.getProperty("pyx.metrics.game.enabled", "false"));
    }
  }

  @Provides
  @GamePermalinkUrlFormat
  String provideGamePermalinkUrlFormat() {
    synchronized (properties) {
      return properties.getProperty("pyx.metrics.game.url_format", "about:blank#%s");
    }
  }

  @Provides
  @ShowRoundPermalink
  Boolean provideShowRoundPermalink() {
    synchronized (properties) {
      return Boolean.valueOf(properties.getProperty("pyx.metrics.round.enabled", "false"));
    }
  }

  @Provides
  @RoundPermalinkUrlFormat
  String provideRoundPermalinkUrlFormat() {
    synchronized (properties) {
      return properties.getProperty("pyx.metrics.round.url_format", "about:blank#%s");
    }
  }

  @Provides
  @ShowSessionPermalink
  Boolean provideShowSessionPermalink() {
    synchronized (properties) {
      return Boolean.valueOf(properties.getProperty("pyx.metrics.session.enabled", "false"));
    }
  }

  @Provides
  @SessionPermalinkUrlFormat
  String provideSessionPermalinkUrlFormat() {
    synchronized (properties) {
      return properties.getProperty("pyx.metrics.session.url_format", "about:blank#%s");
    }
  }

  @Provides
  @ShowUserPermalink
  Boolean provideShowUserPermalink() {
    synchronized (properties) {
      return Boolean.valueOf(properties.getProperty("pyx.metrics.user.enabled", "false"));
    }
  }

  @Provides
  @UserPermalinkUrlFormat
  String provideUserPermalinkUrlFormat() {
    synchronized (properties) {
      return properties.getProperty("pyx.metrics.user.url_format", "about:blank#%s");
    }
  }

  @Provides
  @InsecureIdAllowed
  Boolean provideInsecureIdAllowed() {
    synchronized (properties) {
      return Boolean.valueOf(properties.getProperty(
          "pyx.server.insecure_id_allowed", "true"));
    }
  }

  @Provides
  @IdCodeSalt
  String provideIdCodeSalt() {
    synchronized (properties) {
      return properties.getProperty("pyx.server.id_code_salt", "");
    }
  }

  @Provides
  @CookieDomain
  String getCookieDomain() {
    synchronized (properties) {
      return properties.getProperty("pyx.client.cookie_domain", ".localhost");
    }
  }

  @Provides
  @IncludeInactiveCardsets
  Boolean getIncludeInactiveCardsets() {
    synchronized (properties) {
      return Boolean.valueOf(properties
          .getProperty("pyx.server.include_inactive_cardsets", "false"));
    }
  }

  /**
   * @return A Hibernate session. Objects which receive a Hibernate session should close the
   * session when they are done!
   */
  @Provides
  Session provideHibernateSession() {
    final Session session = HibernateUtil.instance.sessionFactory.openSession();
    if (!session.isConnected()) {
      LOG.error("Session disconnected!");
    }
    return session;
  }

  @Provides
  @Admins
  Set<String> provideAdmins() {
    synchronized (properties) {
      return ImmutableSet
          .copyOf(properties.getProperty("pyx.server.admin_addrs", "127.0.0.1,::1").split(","));
    }
  }

  @Provides
  @BannedNicks
  Set<String> provideBannedNicks() {
    synchronized (properties) {
      return ImmutableSet.copyOf(properties.getProperty("pyx.banned_nicks", "").split(","));
    }
  }

  @Provides
  @AllowBlankCards
  Boolean provideAllowBlankCards() {
    synchronized (properties) {
      return Boolean.valueOf(properties.getProperty("pyx.server.allow_blank_cards", "true"));
    }
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface BanList {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface MaxUsers {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface ShowGamePermalink {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface GamePermalinkUrlFormat {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface ShowRoundPermalink {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface RoundPermalinkUrlFormat {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface ShowSessionPermalink {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface SessionPermalinkUrlFormat {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface ShowUserPermalink {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface UserPermalinkUrlFormat {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface BroadcastConnectsAndDisconnects {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface GlobalChatEnabled {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface GameChatEnabled {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface InsecureIdAllowed {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface IdCodeSalt {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface CookieDomain {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface IncludeInactiveCardsets {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface ServerStarted {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface UniqueId {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface UserPersistentId {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface Admins {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface BannedNicks {
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface AllowBlankCards {
  }
}
