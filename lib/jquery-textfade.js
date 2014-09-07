
/*!
jQuery.TextFade v1.0.0
https://github.com/mdesantis/jquery-textfade

Copyright 2014 Maurizio De Santis
Released under the MIT license
https://github.com/mdesantis/jquery-textfade/LICENSE
 */

(function() {
  var TextFade;

  TextFade = function($element, action, options) {
    var $, BLANK_TEXT_REGEXP, LINES_SPLIT_REGEXP, SEQUENCES, blankText, capitalize, defaultOptions, flatten, max, sequenceClone, shuffle, text, textToSequences, times, zip, _ref;
    this.$element = $element;
    this.action = action;
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
      var i, _results;
      i = 0;
      if (fn == null) {
        fn = function(i) {
          return i;
        };
      }
      _results = [];
      while (i < n) {
        _results.push(fn(i++));
      }
      return _results;
    };
    zip = function(a) {
      var result;
      result = [];
      times(max(a.map(function(v) {
        return v.length;
      })), function(i) {
        var v, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = a.length; _i < _len; _i++) {
          v = a[_i];
          if (v[i] != null) {
            _results.push((result[i] != null ? result[i] : result[i] = []).push(v[i]));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      });
      return result;
    };
    textToSequences = function(text) {
      var charIndex, line, lineIndex, lines, sequences, _i, _len;
      sequences = [];
      charIndex = 0;
      lines = text.match(LINES_SPLIT_REGEXP);
      for (lineIndex = _i = 0, _len = lines.length; _i < _len; lineIndex = ++_i) {
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
    this._trigger = function(event_type) {
      var extraParameters;
      extraParameters = [
        {
          'action': this.action
        }
      ];
      this.$element.trigger("" + event_type + ".textFade" + (capitalize(this.action)), extraParameters);
      return this.$element.trigger("" + event_type + ".textFade", extraParameters);
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
    text = (_ref = this.options.text) != null ? _ref : this.$element.text();
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
