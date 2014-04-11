package net.socialgamer.cah.data;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import net.socialgamer.cah.Constants.CardSetData;
import net.socialgamer.cah.db.CardSet;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.google.inject.Inject;
import com.google.inject.Provider;
import com.google.inject.Singleton;


/**
 * An in-memory cache for all card sets.  Loaded at server startup to prevent unnecessary database traffic.
 * 
 * @author Gavin Lambert (uecasm)
 *
 */
@Singleton
public class CardSets {
  private static final Logger logger = Logger.getLogger(CardSets.class);

  private final ReentrantReadWriteLock lock = new ReentrantReadWriteLock(true);
  private final Map<Integer, CardSet> sets = new HashMap<Integer, CardSet>();
  private final Provider<Session> sessionProvider;
  private final Properties properties;
  private List<Map<CardSetData, Object>> cardSetsData = new ArrayList<Map<CardSetData, Object>>();

  @Inject
  public CardSets(final Provider<Session> sessionProvider, final Properties properties) {
    this.sessionProvider = sessionProvider;
    this.properties = properties;
  }

  /**
   * Reload all card sets from the backing database.
   */
  public void reloadAll() {
    Session session = null;
    try {
      session = sessionProvider.get();
      final Transaction transaction = session.beginTransaction();
      @SuppressWarnings("unchecked")
      final List<CardSet> cardSets = session
          .createQuery(CardSet.getCardsetQuery(properties))
          .setReadOnly(true)
          .list();
      final List<Map<CardSetData, Object>> data = getClientMetadata(cardSets);
      transaction.commit();

      lock.writeLock().lock();
      try {
        sets.clear();
        for (final CardSet cardSet : cardSets) {
          sets.put(cardSet.getId(), cardSet);
        }
        cardSetsData = data;
      } finally {
        lock.writeLock().unlock();
      }
    } catch (final Exception e) {
      logger.error("Unable to load cards", e);
    } finally {
      if (null != session) {
        session.close();
      }
    }
  }

  /**
   * Given a set of card-set ids, returns the actual card sets.  Used when starting a game.
   * 
   * @param ids The ids of the card-sets to return.
   * @return The specified subset of card sets.
   */
  public Set<CardSet> findById(final Collection<Integer> ids)
  {
    if (ids.isEmpty()) {
      return Collections.emptySet();
    }

    final Set<CardSet> cardSets = new HashSet<CardSet>(ids.size());
    lock.readLock().lock();
    try {
      for (final Integer i : ids) {
        final CardSet set = sets.get(i);
        if (set != null) {
          cardSets.add(set);
        }
      }
    } finally {
      lock.readLock().unlock();
    }
    return cardSets;
  }

  /**
   * Returns basic deck metadata for all card sets.  Used at login to populate the game options.
   * 
   * @return The list of card-set client-side metadata.
   */
  public List<Map<CardSetData, Object>> getClientMetadata() {
    lock.readLock().lock();
    try {
      return cardSetsData;
    } finally {
      lock.readLock().unlock();
    }
  }

  /**
   * Returns basic deck metadata for the specified card sets.  As a side effect, also
   * loads internal collections.
   * 
   * @param cardSets The list of card sets for which to retrieve metadata.
   * @return The metadata for the specified sets.
   */
  private List<Map<CardSetData, Object>> getClientMetadata(final List<CardSet> cardSets) {
    final List<Map<CardSetData, Object>> data = new ArrayList<Map<CardSetData, Object>>();
    for (final CardSet cardSet : cardSets) {
      data.add(cardSet.getClientMetadata());
    }
    return data;
  }
}
