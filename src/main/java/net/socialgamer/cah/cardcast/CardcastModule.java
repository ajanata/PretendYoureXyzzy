package net.socialgamer.cah.cardcast;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.util.concurrent.atomic.AtomicInteger;

import net.socialgamer.cah.data.GameOptions;

import com.google.inject.AbstractModule;
import com.google.inject.BindingAnnotation;
import com.google.inject.Provides;


public class CardcastModule extends AbstractModule {

  AtomicInteger cardId = new AtomicInteger(-(GameOptions.MAX_BLANK_CARD_LIMIT + 1));

  @Override
  protected void configure() {
  }

  @Provides
  @CardcastCardId
  Integer provideCardId() {
    return cardId.decrementAndGet();
  }

  @BindingAnnotation
  @Retention(RetentionPolicy.RUNTIME)
  public @interface CardcastCardId {
    /**/
  }
}
