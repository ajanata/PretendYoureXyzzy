package net.socialgamer.cah;


import org.apache.log4j.Logger;
import org.hibernate.cfg.Configuration;

import javax.annotation.Nonnull;
import java.io.*;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * @author Gianlu
 */
public class ConfigurationHolder {
  private static final Logger logger = Logger.getLogger(ConfigurationHolder.class);
  private static ConfigurationHolder instance;
  private final File webContent;
  private final File pyxConfig;
  private final File hibernateConfig;
  private final File log4jConfig;
  private final Map<String, String> startupArgs;
  private final Map<String, String> conf = new HashMap<>();

  private ConfigurationHolder(@Nonnull Map<String, String> args) throws IOException {
    this.startupArgs = Collections.unmodifiableMap(args);

    File pyxDirectory = new File(args.getOrDefault("pyx.server.dir", "./"));

    this.webContent = new File(pyxDirectory, "WebContent");
    if (!webContent.exists() || !webContent.canRead())
      throw new IllegalStateException("Invalid PYX directory, missing WebContent!");

    if (args.get("pyx.server.config") == null) this.pyxConfig = new File(pyxDirectory, "pyx.properties");
    else this.pyxConfig = new File(args.get("pyx.server.config"));

    reloadConfiguration();

    this.hibernateConfig = new File(pyxDirectory, "hibernate.cfg.xml");
    this.log4jConfig = new File(pyxDirectory, "log4j.properties");
  }

  public static void asProperties(Properties props) {
    ConfigurationHolder conf = get();

    for (String key : conf.conf.keySet())
      props.setProperty(key, conf.conf.get(key));
  }

  @Nonnull
  public static ConfigurationHolder get() {
    if (instance == null) throw new IllegalStateException("ConfigurationHolder not initialized!");
    return instance;
  }

  private static Map<String, String> parse(String... args) {
    Map<String, String> map = new HashMap<>();
    for (String arg : args) {
      if (arg.startsWith("--")) {
        arg = arg.substring(2);
        int pos = arg.indexOf('=');
        if (pos == -1) {
          logger.warn("Invalid argument: " + arg);
          continue;
        }

        String value = arg.substring(pos + 1);
        if (value.startsWith("\"") && value.endsWith("\""))
          value = value.substring(1, value.length() - 1);

        map.put(arg.substring(0, pos), value);
      } else {
        logger.warn("Invalid argument: " + arg);
      }
    }
    return map;
  }

  @Nonnull
  public static ConfigurationHolder init(String... args) throws IOException {
    instance = new ConfigurationHolder(parse(args));
    return instance;
  }

  /**
   * Converts encoded &#92;uxxxx to unicode chars
   * and changes special saved chars to their original forms
   */
  private static String loadConvert(char[] in, int off, int len, char[] convtBuf) {
    if (convtBuf.length < len) {
      int newLen = len * 2;
      if (newLen < 0) {
        newLen = Integer.MAX_VALUE;
      }
      convtBuf = new char[newLen];
    }
    char aChar;
    char[] out = convtBuf;
    int outLen = 0;
    int end = off + len;

    while (off < end) {
      aChar = in[off++];
      if (aChar == '\\') {
        aChar = in[off++];
        if (aChar == 'u') {
          // Read the xxxx
          int value = 0;
          for (int i = 0; i < 4; i++) {
            aChar = in[off++];
            switch (aChar) {
              case '0':
              case '1':
              case '2':
              case '3':
              case '4':
              case '5':
              case '6':
              case '7':
              case '8':
              case '9':
                value = (value << 4) + aChar - '0';
                break;
              case 'a':
              case 'b':
              case 'c':
              case 'd':
              case 'e':
              case 'f':
                value = (value << 4) + 10 + aChar - 'a';
                break;
              case 'A':
              case 'B':
              case 'C':
              case 'D':
              case 'E':
              case 'F':
                value = (value << 4) + 10 + aChar - 'A';
                break;
              default:
                throw new IllegalArgumentException(
                        "Malformed \\uxxxx encoding.");
            }
          }
          out[outLen++] = (char) value;
        } else {
          if (aChar == 't') aChar = '\t';
          else if (aChar == 'r') aChar = '\r';
          else if (aChar == 'n') aChar = '\n';
          else if (aChar == 'f') aChar = '\f';
          out[outLen++] = aChar;
        }
      } else {
        out[outLen++] = aChar;
      }
    }
    return new String(out, 0, outLen);
  }

  private static void load(LineReader lr, Map<String, String> args) throws IOException {
    char[] convtBuf = new char[1024];
    int limit;
    int keyLen;
    int valueStart;
    char c;
    boolean hasSep;
    boolean precedingBackslash;

    while ((limit = lr.readLine()) >= 0) {
      c = 0;
      keyLen = 0;
      valueStart = limit;
      hasSep = false;

      //System.out.println("line=<" + new String(lineBuf, 0, limit) + ">");
      precedingBackslash = false;
      while (keyLen < limit) {
        c = lr.lineBuf[keyLen];
        //need check if escaped.
        if ((c == '=' || c == ':') && !precedingBackslash) {
          valueStart = keyLen + 1;
          hasSep = true;
          break;
        } else if ((c == ' ' || c == '\t' || c == '\f') && !precedingBackslash) {
          valueStart = keyLen + 1;
          break;
        }
        if (c == '\\') {
          precedingBackslash = !precedingBackslash;
        } else {
          precedingBackslash = false;
        }
        keyLen++;
      }
      while (valueStart < limit) {
        c = lr.lineBuf[valueStart];
        if (c != ' ' && c != '\t' && c != '\f') {
          if (!hasSep && (c == '=' || c == ':')) {
            hasSep = true;
          } else {
            break;
          }
        }
        valueStart++;
      }
      String key = loadConvert(lr.lineBuf, 0, keyLen, convtBuf);
      String value = loadConvert(lr.lineBuf, valueStart, limit - valueStart, convtBuf);
      args.put(key, value);
    }
  }

  public String getOrDefault(String key, String fallback) {
    return conf.getOrDefault(key, fallback);
  }

  public void reloadConfiguration() throws IOException {
    conf.clear();
    if (pyxConfig.exists() && pyxConfig.canRead())
      load(new LineReader(new FileInputStream(pyxConfig)), conf);
    conf.putAll(startupArgs); // Startup arguments override configuration file
  }

  @Nonnull
  public File getWebContent() {
    return webContent;
  }

  @Nonnull
  public Configuration getHibernateConfiguration() {
    Configuration hibernate = new Configuration();
    hibernate.configure(hibernateConfig);
    if (conf.get("pyx.server.cards_url") != null)
      hibernate.setProperty("hibernate.connection.url", "jdbc:sqlite:" + conf.get("pyx.server.cards_url"));
    return hibernate;
  }

  @Nonnull
  public File getLog4JConfig() {
    return log4jConfig;
  }

  /**
   * Read in a "logical line" from an InputStream/Reader, skip all comment
   * and blank lines and filter out those leading whitespace characters
   * (\u0020, \u0009 and \u000c) from the beginning of a "natural line".
   * Method returns the char length of the "logical line" and stores
   * the line in "lineBuf".
   */
  private static class LineReader {
    byte[] inByteBuf;
    char[] inCharBuf;
    char[] lineBuf = new char[1024];
    int inLimit = 0;
    int inOff = 0;
    InputStream inStream;
    Reader reader;

    public LineReader(InputStream inStream) {
      this.inStream = inStream;
      inByteBuf = new byte[8192];
    }

    public LineReader(Reader reader) {
      this.reader = reader;
      inCharBuf = new char[8192];
    }

    int readLine() throws IOException {
      int len = 0;
      char c = 0;

      boolean skipWhiteSpace = true;
      boolean isCommentLine = false;
      boolean isNewLine = true;
      boolean appendedLineBegin = false;
      boolean precedingBackslash = false;
      boolean skipLF = false;

      while (true) {
        if (inOff >= inLimit) {
          inLimit = (inStream == null) ? reader.read(inCharBuf)
                  : inStream.read(inByteBuf);
          inOff = 0;
          if (inLimit <= 0) {
            if (len == 0 || isCommentLine) {
              return -1;
            }
            if (precedingBackslash) {
              len--;
            }
            return len;
          }
        }
        if (inStream != null) {
          //The line below is equivalent to calling a
          //ISO8859-1 decoder.
          c = (char) (0xff & inByteBuf[inOff++]);
        } else {
          c = inCharBuf[inOff++];
        }
        if (skipLF) {
          skipLF = false;
          if (c == '\n') {
            continue;
          }
        }
        if (skipWhiteSpace) {
          if (c == ' ' || c == '\t' || c == '\f') {
            continue;
          }
          if (!appendedLineBegin && (c == '\r' || c == '\n')) {
            continue;
          }
          skipWhiteSpace = false;
          appendedLineBegin = false;
        }
        if (isNewLine) {
          isNewLine = false;
          if (c == '#' || c == '!') {
            isCommentLine = true;
            continue;
          }
        }

        if (c != '\n' && c != '\r') {
          lineBuf[len++] = c;
          if (len == lineBuf.length) {
            int newLength = lineBuf.length * 2;
            if (newLength < 0) {
              newLength = Integer.MAX_VALUE;
            }
            char[] buf = new char[newLength];
            System.arraycopy(lineBuf, 0, buf, 0, lineBuf.length);
            lineBuf = buf;
          }
          //flip the preceding backslash flag
          if (c == '\\') {
            precedingBackslash = !precedingBackslash;
          } else {
            precedingBackslash = false;
          }
        } else {
          // reached EOL
          if (isCommentLine || len == 0) {
            isCommentLine = false;
            isNewLine = true;
            skipWhiteSpace = true;
            len = 0;
            continue;
          }
          if (inOff >= inLimit) {
            inLimit = (inStream == null)
                    ? reader.read(inCharBuf)
                    : inStream.read(inByteBuf);
            inOff = 0;
            if (inLimit <= 0) {
              if (precedingBackslash) {
                len--;
              }
              return len;
            }
          }
          if (precedingBackslash) {
            len -= 1;
            //skip the leading whitespace characters in following line
            skipWhiteSpace = true;
            appendedLineBegin = true;
            precedingBackslash = false;
            if (c == '\r') {
              skipLF = true;
            }
          } else {
            return len;
          }
        }
      }
    }
  }
}
