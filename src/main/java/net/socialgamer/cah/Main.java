package net.socialgamer.cah;

import io.undertow.Handlers;
import io.undertow.Undertow;
import io.undertow.jsp.JspServletBuilder;
import io.undertow.server.handlers.PathHandler;
import io.undertow.server.handlers.resource.FileResourceManager;
import io.undertow.server.handlers.resource.ResourceHandler;
import io.undertow.servlet.Servlets;
import io.undertow.servlet.api.*;
import net.socialgamer.cah.servlets.*;
import org.apache.jasper.deploy.JspPropertyGroup;
import org.apache.log4j.Logger;
import org.apache.tomcat.InstanceManager;

import javax.servlet.ServletException;
import java.io.IOException;
import java.util.EventListener;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Gianlu
 */
public class Main {

  private static final Logger logger = Logger.getLogger(Main.class);

  public static void main(String[] args) throws ServletException, IOException {
    ConfigurationHolder conf = ConfigurationHolder.init(args);

    int port = Integer.parseInt(conf.getOrDefault("pyx.server.port", "80"));

    FileResourceManager fileResourceManager = new FileResourceManager(conf.getWebContent());

    DeploymentInfo servletBuilder = Servlets.deployment()
            .setClassLoader(Main.class.getClassLoader())
            .setContextPath("/")
            .addWelcomePages("index.jsp", "index.html")
            .addListener(new ListenerInfo(StartupUtils.class, new InstanceFactory<EventListener>() {
              private final StartupUtils startupUtils = new StartupUtils();

              @Override
              public InstanceHandle<EventListener> createInstance() {
                return new InstanceHandle<EventListener>() {
                  @Override
                  public EventListener getInstance() {
                    return startupUtils;
                  }

                  @Override
                  public void release() {
                  }
                };
              }
            }))
            .setDeploymentName("PYX")
            .setResourceManager(fileResourceManager)
            .addFilter(new FilterInfo("SetCacheControl", CacheControlFilter.class))
            .addServlets(
                    JspServletBuilder.createServlet("JspServlet", "*.jsp"),
                    Servlets.servlet("ServerAliveServlet", ServerAliveServlet.class)
                            .addMapping("/ServerAlive"),
                    Servlets.servlet("SchemaServlet", Schema.class)
                            .addMapping("/Schema"),
                    Servlets.servlet("AjaxServlet", AjaxServlet.class)
                            .addMapping("/AjaxServlet"),
                    Servlets.servlet("JsConfigServlet", JavascriptConfigServlet.class)
                            .addMapping("/js/cah.config.js"),
                    Servlets.servlet("LongPollServlet", LongPollServlet.class)
                            .addMapping("/LongPollServlet"));

    JspServletBuilder.setupDeployment(servletBuilder, new HashMap<String, JspPropertyGroup>(), new HashMap<>(), new InstanceManager() {
      private final Map<Class, Object> map = new HashMap<>();

      @Override
      public Object newInstance(Class<?> aClass) throws IllegalAccessException, InstantiationException {
        if (map.get(aClass) == null) {
          Object obj = aClass.newInstance();
          map.put(aClass, obj);
        }

        return map.get(aClass);
      }

      @Override
      public Object newInstance(String s) throws IllegalAccessException, InstantiationException, ClassNotFoundException {
        Class aClass = Main.class.getClassLoader().loadClass(s);
        if (map.get(aClass) == null) {
          Object obj = aClass.newInstance();
          map.put(aClass, obj);
        }

        return map.get(aClass);
      }

      @Override
      public Object newInstance(String s, ClassLoader classLoader) throws IllegalAccessException, InstantiationException, ClassNotFoundException {
        Class aClass = classLoader.loadClass(s);
        if (map.get(aClass) == null) {
          Object obj = aClass.newInstance();
          map.put(aClass, obj);
        }

        return map.get(aClass);
      }

      @Override
      public void newInstance(Object o) {
      }

      @Override
      public void destroyInstance(Object o) {
      }
    });

    DeploymentManager manager = Servlets.defaultContainer().addDeployment(servletBuilder);
    manager.deploy();
    PathHandler path = Handlers.path(new ResourceHandler(fileResourceManager))
            .addPrefixPath("/", manager.start());

    Undertow server = Undertow.builder()
            .addHttpListener(port, "0.0.0.0")
            .setHandler(path)
            .build();
    server.start();

    logger.info("Server started on port " + port);
  }
}