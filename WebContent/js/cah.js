var cah = {};

cah.DEBUG = true;
cah.nickname = "";

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
