/*
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

/**
 * CardSet class and static list.
 * 
 * @author Andy Janata (ajanata@socialgamer.net)
 */

cah.CardSet = {};
/**
 * @type {Object} Key-value map of CardSets. Key is ID, value is the object.
 */
cah.CardSet.list = {};

/**
 * Class containing information about a CardSet. Should only be used by utility function in this
 * file that populates cah.CardSet.list during initial load of the game.
 * 
 * @param {Number}
 *          id CardSet's database/wire ID.
 * @param {String}
 *          name CardSet's name.
 * @param {Boolean}
 *          baseDeck Whether this CardSet can be used as a base deck. At least one base deck must be
 *          used per game.
 * @param {Number}
 *          blackCardCount The number of black cards in this CardSet
 * @param {Number}
 *          whiteCardCount The number of white cards in this CardSet.
 * @constructor
 * @private
 */
cah.CardSet = function(id, name, baseDeck, blackCardCount, whiteCardCount) {
  /**
   * CardSet's database/wire ID.
   * 
   * @type {Number}
   * @private
   */
  this.id_ = id;

  /**
   * CardSet's name.
   * 
   * @type {String}
   * @private
   */
  this.name_ = name;

  /**
   * Whether this CardSet can be used as a base deck. At least one base deck must be used per game.
   * 
   * @type {Boolean}
   * @private
   */
  this.baseDeck_ = baseDeck;

  /**
   * The number of black cards in this CardSet.
   * 
   * @type {Number}
   * @private
   */
  this.blackCardCount_ = blackCardCount;

  /**
   * The number of white cards in this CardSet.
   * 
   * @type {Number}
   * @private
   */
  this.whiteCardCount_ = whiteCardCount;
};

/**
 * @returns {number} This CardSet's database/wire ID.
 */
cah.CardSet.prototype.getId = function() {
  return this.id_;
};

/**
 * @returns {String} This CardSet's name.
 */
cah.CardSet.prototype.getName = function() {
  return this.name_;
};

/**
 * @returns {Boolean} Whether this CardSet can be used as the base deck in a game.
 */
cah.CardSet.prototype.isBaseDeck = function() {
  return this.baseDeck_;
};

/**
 * @returns {Number} The number of black cards in this CardSet.
 */
cah.CardSet.prototype.getBlackCardCount = function() {
  return this.blackCardCount_;
};

/**
 * @returns {Number} The number of white cards in this CardSet.
 */
cah.CardSet.prototype.getWhiteCardCount = function() {
  return this.whiteCardCount_;
};

/**
 * Populate the internal list of CardSets from data provided by the server.
 * 
 * @param {Array}
 *          cardSets Array of CardSet data from server.
 */
cah.CardSet.populateCardSets = function(cardSets) {
  cah.CardSet.list = {};
  for ( var key in cardSets) {
    var cardSetData = cardSets[key];
    var cardSet = new cah.CardSet(cardSetData[cah.$.CardSetData.ID],
        cardSetData[cah.$.CardSetData.CARD_SET_NAME], cardSetData[cah.$.CardSetData.BASE_DECK],
        cardSetData[cah.$.CardSetData.BLACK_CARDS_IN_DECK],
        cardSetData[cah.$.CardSetData.WHITE_CARDS_IN_DECK]);
    cah.CardSet.list[cardSet.getId()] = cardSet;
  }
};
