package net.socialgamer.cah;

import static org.junit.Assert.fail;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

import net.socialgamer.cah.Constants.DuplicationAllowed;

import org.junit.Test;


public class ConstantsTest {

  /**
   * Test to make sure that no two over-the-wire message constants use the same value. In theory, we
   * only need to make sure that it's only unique in a particular enum, but it doesn't hurt to
   * ensure global uniqueness.
   */
  @Test
  public void ensureNoDuplicateValues() throws Exception {
    final Map<String, String> allFields = new HashMap<String, String>();

    final Class<?>[] classes = Constants.class.getClasses();
    for (final Class<?> c : classes) {
      // We only care about enums.
      if (!c.isEnum()) {
        continue;
      }

      final Map<String, String> fields = getEnumValues(c);
      for (final Map.Entry<String, String> entry : fields.entrySet()) {
        if (allFields.containsKey(entry.getValue())) {
          fail(String.format("Value '%s' defined for %s.%s, already defined for %s.",
              entry.getValue(), c.getName(), entry.getKey(), allFields.get(entry.getValue())));
        }
        allFields.put(entry.getValue(), c.getName() + "." + entry.getKey());
      }
    }
  }

  /**
   * Return a map of enum values in an Enum class, with the enum field names as keys and the values
   * of toString() as the values.
   * 
   * Completely ignores enum values annotated with DuplicationAllowed.
   * 
   * @param enumClass
   *          The Enum to examine.
   * @return Map of field name -> toString values.
   * @throws IllegalArgumentException
   *           Thrown if {@code enumClass} isn't actually an enum.
   * @throws IllegalAccessException
   *           If the value was unable to be retrieved.
   */
  private static Map<String, String> getEnumValues(final Class<?> enumClass)
      throws IllegalArgumentException, IllegalAccessException {
    if (!enumClass.isEnum()) {
      throw new IllegalArgumentException(enumClass.getName() + " is not an enum");
    }

    final Field[] flds = enumClass.getDeclaredFields();
    final HashMap<String, String> enumMap = new HashMap<String, String>();
    for (final Field f : flds) {
      if (f.isEnumConstant() && !f.isAnnotationPresent(DuplicationAllowed.class)) {
        enumMap.put(f.getName(), f.get(null).toString());
      }
    }
    return enumMap;
  }
}
