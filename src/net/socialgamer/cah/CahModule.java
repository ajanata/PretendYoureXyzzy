package net.socialgamer.cah;

import com.google.inject.AbstractModule;
import com.google.inject.Singleton;


public class CahModule extends AbstractModule {

  @Override
  protected void configure() {
    // TODO Auto-generated method stub
    bind(Server.class).in(Singleton.class);
  }
}
