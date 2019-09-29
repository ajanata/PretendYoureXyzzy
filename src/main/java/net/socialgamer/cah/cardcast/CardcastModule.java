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

package net.socialgamer.cah.cardcast;

import com.google.inject.*;
import net.socialgamer.cah.CahModule;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.util.concurrent.atomic.AtomicInteger;


public class CardcastModule extends AbstractModule {

    private AtomicInteger cardId;
    private Provider<Integer> maxBlankCardLimitProvider;

    @Override
    protected void configure() {
        maxBlankCardLimitProvider = getProvider(Key.get(Integer.class, CahModule.MaxBlankCardLimit.class));
    }

    @Provides
    @CardcastCardId
    Integer provideCardId() {
        if (cardId == null)    cardId = new AtomicInteger(-(maxBlankCardLimitProvider.get() + 1));
        return cardId.decrementAndGet();
    }

    @BindingAnnotation
    @Retention(RetentionPolicy.RUNTIME)
    public @interface CardcastCardId {
        /**/
    }
}
