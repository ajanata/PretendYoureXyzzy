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

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;


/**
 * Wrap around an {@code JSONObject}, to allow parameters to be retrieved by enum value.
 * 
 * @author Gavin Lambert (uecasm)
 */
public class JsonWrapper {
  private final JSONObject json;

  /**
   * Create a new JsonWrapper.
   * 
   * @param json
   *          The JSON text to parse.
   */
  public JsonWrapper(final String json) {
    this.json = (JSONObject) JSONValue.parse(json);
  }

  /**
   * Returns the value of a property as an Object, or null if the property does not exist.
   * 
   * @param key
   *          Property to get (should be one of the defined Constants).
   * @return Value of the property, or null if property does not exist.
   */
  public Object getValue(final Object key) {
    return json.get(key.toString());
  }

  /**
   * Returns the value of a property as a String, or the default if the parameter does not exist.
   * 
   * @param parameter
   *          Parameter to get.
   * @param defaultValue
   *          The value to return if the parameter does not exist.
   * @return Value of parameter, or the default if parameter does not exist.
   */
  public String getString(final Object key, final String defaultValue) {
    final Object value = getValue(key);
    return (value == null) ? defaultValue : value.toString();
  }

  /**
   * Returns the value of a property as an integer, or the default if the parameter does not exist.
   * 
   * @param parameter
   *          Parameter to get.
   * @param defaultValue
   *          The value to return if the parameter does not exist.
   * @return Value of parameter, or the default if parameter does not exist.
   */
  public int getInteger(final Object key, final int defaultValue) {
    final Object value = getValue(key);
    if (value instanceof Number) {
      return ((Number) value).intValue();
    }
    return (value == null) ? defaultValue : Integer.parseInt(value.toString());
  }

  /**
   * Returns the value of a property as a boolean, or the default if the parameter does not exist.
   * 
   * @param parameter
   *          Parameter to get.
   * @param defaultValue
   *          The value to return if the parameter does not exist.
   * @return Value of parameter, or the default if parameter does not exist.
   */
  public boolean getBoolean(final Object key, final boolean defaultValue) {
    final Object value = getValue(key);
    if (value instanceof Boolean) {
      return (Boolean) value;
    }
    return (value == null) ? defaultValue : Boolean.parseBoolean(value.toString());
  }
}
