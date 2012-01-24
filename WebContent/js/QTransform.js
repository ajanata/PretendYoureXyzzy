/*
 * based off of Louis-Rémi Babé rotate plugin (https://github.com/lrbabe/jquery.rotate.js)
 * 
 * cssTransforms: jQuery cssHooks adding a cross browser, animatible transforms
 * 
 * Author Bobby Schultz
 */
//
(function($) {

  var div = document.createElement('div'), divStyle = div.style;

  // give props to those who dont have them
  $.cssProps.transform = divStyle.MozTransform === '' ? 'MozTransform'
      : (divStyle.msTransform === '' ? 'msTransform'
          : (divStyle.WebkitTransform === '' ? 'WebkitTransform'
              : (divStyle.OTransform === '' ? 'OTransform'
                  : (divStyle.Transform === '' ? 'Transform' : false))));
  $.cssProps.transformOrigin = divStyle.MozTransformOrigin === '' ? 'MozTransformOrigin'
      : (divStyle.msTransformOrigin === '' ? 'msTransformOrigin'
          : (divStyle.WebkitTransformOrigin === '' ? 'WebkitTransformOrigin'
              : (divStyle.OTransformOrigin === '' ? 'OTransformOrigin'
                  : (divStyle.TransformOrigin === '' ? 'TransformOrigin' : false))));

  // define supported or not
  $.support.transform = $.cssProps.transform !== false || divStyle.filter === '' ? true : false;
  $.support.transformOrigin = $.cssProps.transformOrigin !== false ? true : false;

  // if ONLY IE matrixes are supported (IE9 beta6 will use css3)
  $.support.matrixFilter = (divStyle.filter === '' && $.cssProps.transform === false) ? true
      : false;
  div = null;

  // stop if no form of transforms are supported
  if ($.support.transform === false) {
    return;
  }

  // opt out of letting jquery handle the units for custom setters/getters
  $.cssNumber.skew = $.cssNumber.skewX = $.cssNumber.skewY = $.cssNumber.scale = $.cssNumber.scaleX = $.cssNumber.scaleY = $.cssNumber.rotate = $.cssNumber.matrix = true;

  $.cssNumber.transformOrigin = $.cssNumber.transformOriginX = $.cssNumber.transformOriginY = true;

  if ($.support.matrixFilter) {
    $.cssNumber.transformOrigin = $.cssNumber.transformOriginX = $.cssNumber.transformOriginY = true;

    $.cssProps.transformOrigin = 'matrixFilter';
  }

  $.cssHooks.transform = {
    set : function(elem, val, unit) {
      if ($.support.matrixFilter) {
        elem.style.filter = [ val ].join('');
      } else {
        elem.style[$.cssProps.transform] = val + '%';
      }
    },
    get : function(elem, computed) {
      if ($.support.matrixFilter) {
        return elem.style.filter;
      } else {
        return elem.style[$.cssProps.transform];
      }
    }
  };

  $.cssHooks.transformOrigin = {
    set : function(elem, val, unit) {
      if (!$.support.matrixFilter) {
        val = (typeof val === 'string') ? val : val + (unit || '%');
        elem.style[$.cssProps.transformOrigin] = val;
      } else {
        val = val.split(",");
        $.cssHooks.transformOriginX.set(elem, val[0]);
        if (val.length > 1) {
          $.cssHooks.transformOriginY.set(elem, val[1]);
        }
      }
    },
    get : function(elem, computed) {
      if (!$.support.matrixFilter) {
        return elem.style[$.cssProps.transformOrigin];
      } else {
        var originX = $.data(elem, 'transformOriginX');
        var originY = $.data(elem, 'transformOriginY');
        return originX && originY && originX === originY ? originX : '50%';
      }
    }
  };

  $.fx.step.transformOrigin = function(fx) {
    $.cssHooks.transformOrigin.set(fx.elem, fx.now, fx.unit);
  };

  $.cssHooks.transformOriginX = {
    set : function(elem, val, unit) {
      if (!$.support.matrixFilter) {
        val = (typeof val === 'string') ? val : val + (unit || '%');
        elem.style[$.cssProps.transformOrigin + 'X'] = val;
      } else {
        $.data(elem, 'transformOriginX', unit ? val + unit : val);
        setIEMatrix(elem);
      }
    },
    get : function(elem, computed) {
      if (!$.support.matrixFilter) {
        return elem.style[$.cssProps.transformOrigin + 'X'];
      } else {
        var originX = $.data(elem, 'transformOriginX');
        switch (originX) {
          case 'left':
            return '0%';
          case 'center':
            return '50%';
          case 'right':
            return '100%';
        }
        return originX ? originX : '50%';
      }
    }
  };

  $.fx.step.transformOriginX = function(fx) {
    $.cssHooks.transformOriginX.set(fx.elem, fx.now, fx.unit);
  };

  $.cssHooks.transformOriginY = {
    set : function(elem, val, unit) {
      if (!$.support.matrixFilter) {
        val = (typeof val === 'string') ? val : val + (unit || '%');
        elem.style[$.cssProps.transformOrigin + 'Y'] = val;
      } else {
        $.data(elem, 'transformOriginY', unit ? val + unit : val);
        setIEMatrix(elem);
      }
    },
    get : function(elem, computed) {
      if (!$.support.matrixFilter) {
        return elem.style[$.cssProps.transformOrigin + 'Y'];
      } else {
        var originY = $.data(elem, 'transformOriginY');
        switch (originY) {
          case 'top':
            return '0%';
          case 'center':
            return '50%';
          case 'bottom':
            return '100%';
        }
        return originY ? originY : '50%';
      }
    }
  };

  $.fx.step.transformOriginY = function(fx) {
    $.cssHooks.transformOriginY.set(fx.elem, fx.now, fx.unit);
  };

  // create hooks for css transforms
  var rtn = function(v) {
    return v;
  };
  var xy = [ [ 'X', 'Y' ], 'X', 'Y' ];
  var abcdxy = [ [ 'A', 'B', 'C', 'D', 'X', 'Y' ], 'A', 'B', 'C', 'D', 'X', 'Y' ];
  var props = [
      {
        prop : 'rotate',
        matrix : [ function(v) {
          return Math.cos(v);
        }, function(v) {
          return -Math.sin(v);
        }, function(v) {
          return Math.sin(v);
        }, function(v) {
          return Math.cos(v);
        } ],
        unit : 'rad',
        subProps : [ '' ],
        fnc : toRadian
      },
      {
        prop : 'scale',
        matrix : [ [ rtn, 0, 0, rtn ], [ rtn, 0, 0, 1 ], [ 1, 0, 0, rtn ] ],
        unit : '',
        subProps : xy,
        fnc : parseFloat,
        _default : 1
      },
      {
        prop : 'skew',
        matrix : [ [ 1, rtn, rtn, 1 ], [ 1, rtn, 0, 1 ], [ 1, 0, rtn, 1 ] ],
        unit : 'rad',
        subProps : xy,
        fnc : toRadian
      },
      {
        prop : 'translate',
        matrix : [ [ 1, 0, 0, 1, rtn, rtn ], [ 1, 0, 0, 1, rtn, 0 ], [ 1, 0, 0, 1, 0, rtn ] ],
        standardUnit : 'px',
        subProps : xy,
        fnc : parseFloat
      },
      {
        prop : 'matrix',
        matrix : [ [ rtn, rtn, rtn, rtn, rtn, rtn ], [ rtn, 0, 0, 1, 0, 0 ],
            [ 1, rtn, 0, 1, 0, 0 ], [ 1, 0, rtn, 1, 0, 0 ], [ 1, 0, 0, rtn, 0, 0 ],
            [ 1, 0, 0, 1, 0, rtn ] ],
        subProps : abcdxy,
        fnc : parseFloat
      } ];

  jQuery.each(props, function(n, prop) {
    jQuery.each(prop.subProps, function(num, sub) {
      var _cssProp, _prop = prop;

      if ($.isArray(sub)) {
        // composite transform
        _cssProp = _prop.prop;
        var _sub = sub;
        $.cssHooks[_cssProp] = {
          set : function(elem, val, unit) {
            jQuery.each(_sub, function(num, x) {
              $.cssHooks[_cssProp + x].set(elem, val, unit);
            });
          },
          get : function(elem, computed) {
            var val = [];
            jQuery.each(_sub, function(num, x) {
              val.push($.cssHooks[_cssProp + x].get(elem, val));
            });
            // hack until jQuery supports animating multiple properties
            return val[0] || val[1];
          }
        };
      } else {
        // independent transfrom
        _cssProp = _prop.prop + sub;
        $.cssHooks[_cssProp] = {
          set : function(elem, val, unit) {
            $.data(elem, _cssProp, unit ? val + unit : val);

            setCSSTransform(elem, _prop.fnc(unit ? val + unit : val), _cssProp, _prop.unit || unit
                || _prop.standardUnit);
          },
          get : function(elem, computed) {

            var p = $.data(elem, _cssProp);
            // console.log(_cssProp+'get:'+p);
            return p && p !== undefined ? p : _prop._default || 0;
          }
        };
      }

      $.fx.step[_cssProp] = function(fx) {
        fx.unit = fx.unit === 'px' && $.cssNumber[_cssProp] ? _prop.standardUnit : fx.unit;
        var unit = ($.cssNumber[_cssProp] ? '' : fx.unit);
        $.cssHooks[_cssProp].set(fx.elem, fx.now, fx.unit);
      };
    });
  });

  function setCSSTransform(elem, val, prop, unit) {
    if ($.support.matrixFilter) {
      return setIEMatrix(elem, val);
    }

    // parse css string
    var allProps = parseCSSTransform(elem);

    // check for value to be set
    var a = /[X|Y]/.exec(prop);
    a = (a === null ? '' : a[0] ? a[0] : a);
    prop = /.*[^XY]/.exec(prop)[0];
    unit = unit === undefined ? '' : unit;

    // create return string
    var result = '';
    var wasUpdated = false;
    var arr;
    if (allProps !== null) {
      for ( var item in allProps) {
        arr = allProps[item];
        if (prop === item) {
          // update parsed data with new value
          if (prop !== 'matrix') {
            result += prop + '(';
            result += a === 'X' || a === '' ? val + unit : (arr[0] !== '' ? arr[0]
                : $.cssHooks[prop + 'X'].get(elem) + unit);
            result += a === 'Y' ? ', ' + val + unit : (arr[1] !== '' ? ', ' + arr[1]
                : (prop + 'Y' in $.cssHooks ? ', ' + $.cssHooks[prop + 'Y'].get(elem) + unit : ''));
            result += ') ';
          } else {
            result += val + ' ';
          }
          wasUpdated = true;
        } else {
          // dump parsed data to string
          result += item + '(';
          for ( var i = 0; i < arr.length; i++) {
            result += arr[i];
            if (i < arr.length - 1 && arr[i + 1] !== '') {
              result += ', ';
            } else {
              break;
            }
          }
          result += ') ';
        }
      }
    }

    // if prop was not found to be updated, then dump data
    if (!wasUpdated) {
      result += prop + a + '(' + val + unit + ') ';
    }

    // set all transform properties
    elem.style[$.cssProps.transform] = result;
  }

  function parseCSSTransform(elem) {
    var props, prop, name, transform;
    // break up into single transform calls
    $(elem.style[$.cssProps.transform].replace(/(?:\,\s|\)|\()/g, "|").split(" "))
    // read each data point for the transform call
    .each(function(i, item) {
      if (item !== '') {
        if (props === undefined) {
          props = {};
        }
        prop = item.split("|");
        name = prop.shift();
        transform = /.*[^XY]/.exec(name)[0];
        if (!props[transform]) {
          props[transform] = [ '', '', '', '', '', '' ];
        }
        if (!/Y/.test(name)) {
          props[transform][0] = prop[0];
        }
        if (!/X/.test(name)) {
          props[transform][1] = prop[1];
        }
        if (prop.length == 6) {
          props[transform][2] = prop[2];
          props[transform][3] = prop[3];
          props[transform][4] = prop[4];
          props[transform][5] = prop[5];
        }
      }
    });

    return props !== undefined ? props : null;
  }

  function ieOrigin(o, n, percent) {
    return percent * (o - n);
  }

  function toRadian(value) {
    if (typeof value === 'number') {
      return parseFloat(value);
    }
    if (value.indexOf("deg") != -1) {
      return parseInt(value, 10) * (Math.PI * 2 / 360);
    } else if (value.indexOf("grad") != -1) {
      return parseInt(value, 10) * (Math.PI / 200);
    }
  }

  $.rotate = {
    radToDeg : function radToDeg(rad) {
      return rad * 180 / Math.PI;
    }
  };

  // special case for IE matrix
  function setIEMatrix(elem, mat) {
    var inverse, current, ang, org, originX, originY, runTransform = $.cssProps.transformOrigin === 'matrixFilter' ? true
        : false;

    current = [ $.cssHooks.scaleX.get(elem), toRadian($.cssHooks.skewY.get(elem)),
        toRadian($.cssHooks.skewX.get(elem)), $.cssHooks.scaleY.get(elem),
        $.cssHooks.translateX.get(elem), $.cssHooks.translateY.get(elem) ];

    // start by multiply inverse of transform origin by matrix
    if (runTransform) {
      elem.style.filter = [ "progid:DXImageTransform.Microsoft.Matrix"
          + "(M11=1,M12=0,M21=0,M22=1,SizingMethod='auto expand')" ].join('');
      var Wp = $.cssHooks.transformOriginX.get(elem);
      var Hp = $.cssHooks.transformOriginY.get(elem);
      Wp = Wp.indexOf('%') > 0 ? (/[\d]*/.exec(Wp) / 100) : Wp;
      Hp = Hp.indexOf('%') > 0 ? (/[\d]*/.exec(Hp) / 100) : Hp;

      var Wb = elem.offsetWidth;
      var Hb = elem.offsetHeight;
    }

    // multiply old matrix to new matrix
    if (typeof mat !== 'array' || mat.length !== 6) {
      mat = current;
    } else {
      mat = [ ((current[0] * mat[0]) + (current[1] * mat[2])),
          ((current[0] * mat[1]) + (current[1] * mat[3])),
          ((current[2] * mat[0]) + (current[3] * mat[2])),
          ((current[2] * mat[1]) + (current[3] * mat[3])), mat[4], mat[5] ];
    }

    // multiply the transform and rotation matrixes
    ang = $.data(elem, 'rotate');
    if (ang) {
      ang = toRadian(ang);
      var cos = Math.cos(ang);
      var sin = Math.sin(ang);

      ang = [ cos, -sin, sin, cos ];
      mat = [ ((mat[0] * ang[0]) + (mat[1] * ang[2])), ((mat[0] * ang[1]) + (mat[1] * ang[3])),
          ((mat[2] * ang[0]) + (mat[3] * ang[2])), ((mat[2] * ang[1]) + (mat[3] * ang[3])), mat[4],
          mat[5] ];
    }

    // apply the matrix as a IE filter
    elem.style.filter = [ "progid:DXImageTransform.Microsoft.Matrix(", "M11=" + mat[0] + ", ",
        "M12=" + mat[1] + ", ", "M21=" + mat[2] + ", ", "M22=" + mat[3] + ", ",
        "SizingMethod='auto expand'", ")" ].join('');

    if (runTransform) {
      var Wo = elem.offsetWidth;
      var Ho = elem.offsetHeight;
      elem.style.position = 'relative';
      elem.style.left = Wp * (Wb - Wo) + (parseInt(mat[4]) || 0);
      elem.style.top = Hp * (Hb - Ho) + (parseInt(mat[5]) || 0);
    }
    // $('#console').append('<div>
    // trans:'+Wp+":"+Wb+":"+Wo+":"+mat[4]+":"+elem.style.left+'</div>');

  }

})(jQuery);
