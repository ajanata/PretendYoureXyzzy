package net.socialgamer.cah.data;

import java.util.HashMap;
import java.util.Map;


public class BidiFromIdHashMap<K, V extends HasId> extends HashMap<K, V> {
  private static final long serialVersionUID = -6042089713019604402L;
  private final Map<Integer, K> reverseIdMap = new HashMap<Integer, K>();

  @Override
  public V put(final K key, final V value) {
    reverseIdMap.put(value.getId(), key);
    return super.put(key, value);
  }

  public boolean hasKeyForId(final int id) {
    return reverseIdMap.containsKey(id);
  }

  public K getKeyForId(final int id) {
    return reverseIdMap.get(id);
  }
}
