package net.socialgamer.cah;

import io.undertow.Handlers;
import io.undertow.Undertow;
import io.undertow.jsp.JspServletBuilder;
import io.undertow.server.handlers.PathHandler;
import io.undertow.server.handlers.resource.FileResourceManager;
import io.undertow.server.handlers.resource.ResourceHandler;
import io.undertow.servlet.Servlets;
import io.undertow.servlet.api.*;
import net.socialgamer.cah.servlets.AjaxServlet;
import net.socialgamer.cah.servlets.JavascriptConfigServlet;
import net.socialgamer.cah.servlets.LongPollServlet;
import org.apache.jasper.deploy.JspPropertyGroup;
import org.apache.jasper.deploy.TagLibraryInfo;
import org.apache.tomcat.InstanceManager;

import javax.servlet.ServletException;
import java.io.File;
import java.net.URISyntaxException;
import java.util.EventListener;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Gianlu
 */
public class Main {

  public static void main(String[] args) throws ServletException, URISyntaxException {
    System.out.println(new File(Main.class.getProtectionDomain().getCodeSource().getLocation().toURI()).getPath());

    FileResourceManager fileResourceManager = new FileResourceManager(new File("C:\\Users\\Gianlu\\Documents\\Java projects\\PretendYoureXyzzy\\WebContent"));

    DeploymentInfo servletBuilder = Servlets.deployment()
            .setClassLoader(Main.class.getClassLoader())
            .setContextPath("/")
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
            .setDeploymentName("test.war")
            .setResourceManager(fileResourceManager)
            .addServlets(
                    JspServletBuilder.createServlet("Default Jsp Servlet", "*.jsp"),
                    Servlets.servlet("AjaxServlet", AjaxServlet.class)
                            .addMapping("/AjaxServlet"),
                    Servlets.servlet("JsConfigServlet", JavascriptConfigServlet.class)
                            .addMapping("/js/cah.config.js"),
                    Servlets.servlet("LongPollServlet", LongPollServlet.class)
                            .addMapping("/LongPollServlet"));

    JspServletBuilder.setupDeployment(servletBuilder, new HashMap<String, JspPropertyGroup>(), new HashMap<String, TagLibraryInfo>(), new InstanceManager() {
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
            .addHttpListener(8080, "0.0.0.0")
            .setHandler(path)
            .build();
    server.start();
  }
}