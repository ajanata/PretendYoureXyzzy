/**
 * Copyright (c) 2012-2018, Andy Janata
 * All rights reserved.
 * <p>
 * Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 * <p>
 * * Redistributions of source code must retain the above copyright notice, this list of conditions
 * and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice, this list of
 * conditions and the following disclaimer in the documentation and/or other materials provided
 * with the distribution.
 * <p>
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

import net.socialgamer.cah.Constants.DoubleLocalizable;
import net.socialgamer.cah.Constants.GoDataType;
import net.socialgamer.cah.Constants.GoStruct;
import net.socialgamer.cah.Constants.Localizable;

import java.io.File;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;


/**
 * Analyze the server enums using reflection and create a Go version for the IRC bridge to use.
 *
 * @author Andy Janata (ajanata@socialgamer.net)
 */
public class UpdateGoConstants {

  private static final String enumHeaderFmt = "// %s\r\nconst (\r\n";
  private static final String enumValueFmt = "\t%s_%s = \"%s\"\r\n";
  private static final String enumTailFmt = ")\r\n";

  private static final String structHeaderFmt = "type %s struct {\r\n";
  private static final String structValueFmt = "\t%s %s `json:\"%s\"`\r\n";
  private static final String structTailFmt = "}\r\n";

  private static final String msgHeaderFmt = "var %sMsgs = map[string]string{\r\n";
  private static final String msgValueFmt = "\t \"%s\": \"%s\",\r\n";
  private static final String msgTailFmt = "}\r\n";

  private static final String msg2HeaderFmt = "var %sMsgs2 = map[string]string{\r\n";
  private static final String msg2ValueFmt = "\t \"%s\": \"%s\",\r\n";
  private static final String msg2TailFmt = "}\r\n";

  /**
   * Run the enum updater. The working directory for this program should be the project's root.
   *
   * @param args
   */
  @SuppressWarnings("rawtypes")
  public static void main(final String[] args) throws Exception {
    final String dir = "";
    final File outFile = new File(dir + "constants.go");
    assert outFile.canWrite();
    assert outFile.delete();
    assert outFile.createNewFile();
    final PrintWriter writer = new PrintWriter(outFile);

    writer.println("// This file is automatically generated. Do not edit.");
    writer.println();
    writer.println("package pyx");
    writer.println();
    writer.println("import ()");
    writer.println();

    final Class[] classes = Constants.class.getClasses();
    for (final Class<?> c : classes) {
      // We only care about enums.
      if (!c.isEnum()) {
        continue;
      }
      // We need to know the name of the enum itself, not that it's Constants$Foo.
      final String cName = c.getName().split("\\$")[1];
      System.out.println(cName);

      writer.format(enumHeaderFmt, cName);
      final Map<String, String> values = getEnumValues(c);
      for (final String key : values.keySet()) {
        final String value = values.get(key);
        writer.format(enumValueFmt, cName, key, value);
      }
      writer.println(enumTailFmt);

      if (c.isAnnotationPresent(GoStruct.class)) {
        writer.format(structHeaderFmt, cName);
        for (final String key : values.keySet()) {
          final String value = values.get(key);
          String type = "string";
          if (c.getField(key).isAnnotationPresent(GoDataType.class)) {
            type = c.getField(key).getAnnotation(GoDataType.class).value();
          }
          writer.format(structValueFmt, formatGoName(key), type, value);
        }
        writer.println(structTailFmt);
      }

      if (Localizable.class.isAssignableFrom(c) || DoubleLocalizable.class.isAssignableFrom(c)) {
        System.out.println(cName + "_msg");
        writer.format(msgHeaderFmt, cName);
        final Map<String, String> messages = getEnumMessageValues(c);
        for (final String key : messages.keySet()) {
          final String value = messages.get(key);
          writer.format(msgValueFmt, key, value);
        }
        writer.println(msgTailFmt);
      }

      if (DoubleLocalizable.class.isAssignableFrom(c)) {
        System.out.println(cName + "_msg_2");
        writer.format(msg2HeaderFmt, cName);
        final Map<String, String> messages = getEnumMessage2Values(c);
        for (final String key : messages.keySet()) {
          final String value = messages.get(key);
          writer.format(msg2ValueFmt, key, value);
        }
        writer.println(msg2TailFmt);
      }
      writer.println();
    }
    writer.flush();
    writer.close();
  }

  private static String formatGoName(final String constName) {
    final StringBuilder out = new StringBuilder(constName.length());
    for (final String part : constName.split("_")) {
      out.append(part.substring(0, 1).toUpperCase(Locale.ENGLISH));
      out.append(part.substring(1).toLowerCase(Locale.ENGLISH));
    }
    return out.toString();
  }

  /**
   * Return a map of enum values in an Enum class, with the enum field names as keys and the values
   * of toString() as the values.
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
    final HashMap<String, String> enumMap = new HashMap<>();
    for (final Field f : flds) {
      if (f.isEnumConstant()) {
        enumMap.put(f.getName(), f.get(null).toString());
      }
    }
    return enumMap;
  }

  /**
   * Return a map of {@code Localizable} message values in an Enum class, with the enum field names
   * as keys and the values of getString() as the values.
   *
   * @param enumClass
   *          The Enum to examine.
   * @return Map of field name -> getString values.
   * @throws IllegalArgumentException
   *           Thrown if {@code enumClass} isn't actually an enum.
   * @throws IllegalAccessException
   *           If the value was unable to be retrieved.
   */
  private static Map<String, String> getEnumMessageValues(final Class<?> enumClass)
          throws IllegalArgumentException, IllegalAccessException {
    if (!enumClass.isEnum()) {
      throw new IllegalArgumentException(enumClass.getName() + " is not an enum");
    } else if (!Localizable.class.isAssignableFrom(enumClass)
            && !DoubleLocalizable.class.isAssignableFrom(enumClass)) {
      throw new IllegalArgumentException(enumClass.getName()
              + " does not implement Localizable or DoubleLocalizable.");
    }

    final Field[] flds = enumClass.getDeclaredFields();
    final HashMap<String, String> messageMap = new HashMap<>();
    for (final Field f : flds) {
      if (f.isEnumConstant()) {
        if (Localizable.class.isAssignableFrom(enumClass)) {
          messageMap.put(f.get(null).toString(), ((Localizable) f.get(null)).getString());
        } else {
          messageMap.put(f.get(null).toString(), ((DoubleLocalizable) f.get(null)).getString());
        }
      }
    }
    return messageMap;
  }

  /**
   * Return a map of {@code DoubleLocalizable} message values in an Enum class, with the enum field
   * names as keys and the values of getString2() as the values.
   *
   * @param enumClass
   *          The Enum to examine.
   * @return Map of field name -> getString2 values.
   * @throws IllegalArgumentException
   *           Thrown if {@code enumClass} isn't actually an enum.
   * @throws IllegalAccessException
   *           If the value was unable to be retrieved.
   */
  private static Map<String, String> getEnumMessage2Values(final Class<?> enumClass)
          throws IllegalArgumentException, IllegalAccessException {
    if (!enumClass.isEnum()) {
      throw new IllegalArgumentException(enumClass.getName() + " is not an enum");
    } else if (!DoubleLocalizable.class.isAssignableFrom(enumClass)) {
      throw new IllegalArgumentException(enumClass.getName()
              + " does not implement DoubleLocalizable.");
    }

    final Field[] flds = enumClass.getDeclaredFields();
    final HashMap<String, String> messageMap = new HashMap<>();
    for (final Field f : flds) {
      if (f.isEnumConstant()) {
        messageMap.put(f.get(null).toString(), ((DoubleLocalizable) f.get(null)).getString2());
      }
    }
    return messageMap;
  }
}
