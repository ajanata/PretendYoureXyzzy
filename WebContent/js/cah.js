var cah = {};

cah.DEBUG = true;

/**
 * This client's nickname.
 * 
 * @type {string}
 */
cah.nickname = "";

/**
 * The current game this client is playing in. This may be a list later if I expand to multiple
 * concurrent game support.
 * 
 * @type {cah.Game}
 */
cah.currentGame = undefined;

/**
 * Binds a function to a "this object". Result is a new function that will do the right thing across
 * contexts.
 * 
 * @param {Object}
 *          selfObj Object for "this" when calling the returned function.
 * @param {Function}
 *          func Function to call with selfObjc as "this".
 * @returns {Function}
 */
cah.bind = function(selfObj, func) {
  return function() {
    func.apply(selfObj, arguments);
  };
};

/**
 * Inherit the proto methods from one constructor to another.
 * 
 * @param {Function}
 *          childCtor Child class.
 * @param {Function}
 *          parentCtor Parent class.
 */
cah.inherits = function(childCtor, parentCtor) {
  /** @constructor */
  function tempCtor() {
    // pass
  }
  ;

  tempCtor.prototype = parentCtor.prototype;
  childCtor.superClass_ = parentCtor.prototype;
  childCtor.prototype = new tempCtor();
  childCtor.prototype.constructor = childCtor;
};
