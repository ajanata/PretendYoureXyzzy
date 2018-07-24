package net.socialgamer.cah;

import javax.annotation.Nonnull;
import java.io.File;

/**
 * @author Gianlu
 */
public class ConfigurationHolder {
  private static ConfigurationHolder instance;
  private final File pyxDirectory;
  private final File webContent;
  private final File mainConfig;
  private final File hibernateConfig;
  private final File log4jConfig;

  private ConfigurationHolder(@Nonnull File pyxDirectory) {
    this.pyxDirectory = pyxDirectory;

    this.webContent = new File(pyxDirectory, "WebContent");
    if (!webContent.exists() || !webContent.canRead())
      throw new IllegalStateException("Invalid PYX directory, missing WebContent!");

    this.mainConfig = new File(pyxDirectory, "pyx.properties");
    this.hibernateConfig = new File(pyxDirectory, "hibernate.cfg.xml");
    this.log4jConfig = new File(pyxDirectory, "log4j.properties");
  }

  @Nonnull
  public static ConfigurationHolder get() {
    if (instance == null) throw new IllegalStateException("ConfigurationHolder not initialized!");
    return instance;
  }

  @Nonnull
  public static ConfigurationHolder init(@Nonnull File pyxDirectory) {
    instance = new ConfigurationHolder(pyxDirectory);
    return instance;
  }

  @Nonnull
  public File getWebContent() {
    return webContent;
  }

  @Nonnull
  public File getHibernateConfig() {
    return hibernateConfig;
  }

  @Nonnull
  public File getPyxConfig() {
    return mainConfig;
  }

  @Nonnull
  public File getLog4JConfig() {
    return log4jConfig;
  }
}
