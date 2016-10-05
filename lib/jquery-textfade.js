
/*!
jQuery.TextFade v1.0.0
https://github.com/mdesantis/jquery-textfade

Copyright 2014 Maurizio De Santis
Released under the MIT license
https://github.com/mdesantis/jquery-textfade/LICENSE
 */

(function() {
  var TextFade;

  TextFade = function($element, action1, options) {
    var $, BLANK_TEXT_REGEXP, LINES_SPLIT_REGEXP, SEQUENCES, blankText, capitalize, defaultOptions, flatten, max, ref, sequenceClone, shuffle, text, textToSequences, times, zip;
    this.$element = $element;
    this.action = action1;
    $ = jQuery;
    BLANK_TEXT_REGEXP = /[^\n]/g;
    LINES_SPLIT_REGEXP = /.+\n?|\n/g;
    SEQUENCES = {
      'random': function(text) {
        return shuffle(times(text.length));
      },
      'ltr_ttb': function(text) {
        return times(text.length);
      },
      'ltr_btt': function(text) {
        return flatten((textToSequences(text)).reverse());
      },
      'rtl_ttb': function(text) {
        return flatten(textToSequences(text).map(function(v) {
          return v.reverse();
        }));
      },
      'rtl_btt': function(text) {
        return flatten(textToSequences(text).map(function(v) {
          return v.reverse();
        }).reverse());
      },
      'ttb_ltr': function(text) {
        return flatten(zip(textToSequences(text)));
      },
      'ttb_rtl': function(text) {
        return flatten((zip(textToSequences(text).reverse())).reverse());
      },
      'btt_ltr': function(text) {
        return flatten(zip(textToSequences(text).reverse()));
      },
      'btt_rtl': function(text) {
        return flatten((zip(textToSequences(text))).reverse());
      }
    };
    capitalize = function(s) {
      return "" + (s.charAt(0).toUpperCase()) + (s.slice(1));
    };
    flatten = function(a) {
      return a.reduce(function(p, c) {
        return p.concat(c);
      });
    };
    max = function(a) {
      return a.reduce((function(p, c) {
        return Math.max(p, c);
      }), -Infinity);
    };
    shuffle = function(a) {
      var i, j, x;
      i = a.length;
      while (i) {
        j = Math.floor(Math.random() * i);
        x = a[--i];
        a[i] = a[j];
        a[j] = x;
      }
      return a;
    };
    times = function(n, fn) {
      var i, results;
      i = 0;
      if (fn == null) {
        fn = function(i) {
          return i;
        };
      }
      results = [];
      while (i < n) {
        results.push(fn(i++));
      }
      return results;
    };
    zip = function(a) {
      var result;
      result = [];
      times(max(a.map(function(v) {
        return v.length;
      })), function(i) {
        var k, len, results, v;
        results = [];
        for (k = 0, len = a.length; k < len; k++) {
          v = a[k];
          if (v[i] != null) {
            results.push((result[i] != null ? result[i] : result[i] = []).push(v[i]));
          } else {
            results.push(void 0);
          }
        }
        return results;
      });
      return result;
    };
    textToSequences = function(text) {
      var charIndex, k, len, line, lineIndex, lines, sequences;
      sequences = [];
      charIndex = 0;
      lines = text.match(LINES_SPLIT_REGEXP);
      for (lineIndex = k = 0, len = lines.length; k < len; lineIndex = ++k) {
        line = lines[lineIndex];
        sequences[lineIndex] = [];
        times(line.length, function() {
          return sequences[lineIndex].push(charIndex++);
        });
      }
      return sequences;
    };
    defaultOptions = function() {
      return {
        'text': null,
        'sequence': 'random',
        'steps': {
          'duration': 10,
          'threads': 1
        }
      };
    };
    this._trigger = function(eventName) {
      var extraParameters;
      extraParameters = [
        {
          'action': this.action
        }
      ];
      this.$element.trigger(eventName + ".textFade" + (capitalize(this.action)), extraParameters);
      return this.$element.trigger(eventName + ".textFade", extraParameters);
    };
    this._replace = function(index) {
      var nextChar, prevChar, text;
      text = this.$element.text();
      prevChar = this.begText.charAt(index);
      nextChar = this.endText.charAt(index);
      if (prevChar === nextChar) {
        return;
      }
      return this.$element.text("" + (text.substr(0, index)) + nextChar + (text.substr(index + nextChar.length)));
    };
    this._step = function(sequence) {
      times(this.options.steps.threads, (function(_this) {
        return function() {
          if (sequence.length === 0) {
            return;
          }
          return _this._replace(sequence.shift());
        };
      })(this));
      if (sequence.length === 0) {
        clearInterval(this._interval);
        return this._trigger('stop');
      }
    };
    this.options = $.extend(true, defaultOptions(), options);
    text = (ref = this.options.text) != null ? ref : this.$element.text();
    if ($.type(this.options.sequence) === 'string') {
      this.options.sequence = SEQUENCES[this.options.sequence](text);
    } else if ($.isFunction(this.options.sequence)) {
      this.options.sequence = this.options.sequence(text);
    }
    sequenceClone = this.options.sequence.slice(0);
    blankText = text.replace(BLANK_TEXT_REGEXP, ' ');
    switch (this.action) {
      case 'in':
        this.begText = blankText;
        this.endText = text;
        break;
      case 'out':
        this.begText = text;
        this.endText = blankText;
    }
    this.$element.text(this.begText);
    this._trigger('start');
    this._interval = setInterval((function(_this) {
      return function() {
        return _this._step(sequenceClone);
      };
    })(this), this.options.steps.duration);
    return this;
  };

  $.fn.textFade = function(action, options) {
    return this.each(function() {
      return new TextFade($(this), action, options);
    });
  };

  $.fn.textFadeIn = function(options) {
    return this.textFade('in', options);
  };

  $.fn.textFadeOut = function(options) {
    return this.textFade('out', options);
  };

}).call(this);
