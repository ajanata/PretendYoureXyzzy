package net.socialgamer.cah;

import net.socialgamer.cah.data.GameManager;
import net.socialgamer.cah.data.GameManager.GameId;
import net.socialgamer.cah.data.GameManager.MaxGames;

import com.google.inject.AbstractModule;
import com.google.inject.Provides;


public class CahModule extends AbstractModule {

  @Override
  protected void configure() {
    bind(Integer.class).annotatedWith(GameId.class).toProvider(GameManager.class);
  }

  @Provides
  @MaxGames
  Integer provideMaxGames() {
    return 8;
  }
}
