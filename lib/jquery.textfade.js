
/*!
jQuery.TextFade v 1.0.0
https://github.com/mdesantis/jquery.textfade

Copyright 2014 Maurizio De Santis
Released under the MIT license
https://github.com/mdesantis/jquery.textfade/LICENSE
 */

(function() {
  var TextFade;

  TextFade = function($element, action, options) {
    var $, BLANK_TEXT_REGEX, LINES_SPLIT_REGEX, SEQUENCES, blankText, capitalize, defaultSettings, sequenceClone, shuffle, text, textToSequence, times, _base;
    this.$element = $element;
    this.action = action;
    $ = window.jQuery;
    BLANK_TEXT_REGEX = /[^\n]/g;
    LINES_SPLIT_REGEX = /.+\n?|\n/g;
    SEQUENCES = {
      'random': function(text) {
        return shuffle(times(text.length));
      },
      'ltr_ttb': function(text) {
        return times(text.length);
      },
      'ltr_btt': function(text) {
        var sequence;
        sequence = textToSequence(text, function(seqi, c) {
          return seqi.push(c);
        });
        return sequence.reverse().reduce(function(a, b) {
          return a.concat(b);
        });
      },
      'rtl_ttb': function(text) {
        var sequence;
        sequence = textToSequence(text, function(seqi, c) {
          return seqi.unshift(c);
        });
        return sequence.reduce(function(a, b) {
          return a.concat(b);
        });
      },
      'rtl_btt': function(text) {
        var sequence;
        sequence = textToSequence(text, function(seqi, c) {
          return seqi.unshift(c);
        });
        return sequence.reverse().reduce(function(a, b) {
          return a.concat(b);
        });
      }
    };
    textToSequence = function(text, eachLineSequence) {
      var count, i, line, lineSequence, lines, sequence, _i, _len;
      sequence = [];
      count = 0;
      lines = text.match(LINES_SPLIT_REGEX);
      for (i = _i = 0, _len = lines.length; _i < _len; i = ++_i) {
        line = lines[i];
        lineSequence = sequence[i] = [];
        times(line.length, function() {
          eachLineSequence(lineSequence, count);
          return count++;
        });
      }
      return sequence;
    };
    capitalize = function(string) {
      return "" + (string.charAt(0).toUpperCase()) + (string.slice(1));
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
    shuffle = function(array) {
      var i, j, x;
      i = array.length;
      while (i) {
        j = Math.floor(Math.random() * i);
        x = array[--i];
        array[i] = array[j];
        array[j] = x;
      }
      return array;
    };
    defaultSettings = function() {
      return {
        'milliseconds': 1,
        'sequence': 'random',
        'text': null,
        'threads': 1
      };
    };
    this._trigger = function(event_type, extraParameters) {
      if (extraParameters == null) {
        extraParameters = [];
      }
      this.$element.trigger("" + event_type + ".textFade" + (capitalize(this.action)), extraParameters);
      return this.$element.trigger("" + event_type + ".textFade", extraParameters.unshift(this.action));
    };
    this._replace = function(sequence) {
      var index, nextChar, prevChar, text;
      index = sequence.shift();
      text = this.$element.text();
      prevChar = this.begText.charAt(index);
      nextChar = this.endText.charAt(index);
      this._trigger('replace', [prevChar, nextChar]);
      if (prevChar === nextChar) {
        return;
      }
      return this.$element.text("" + (text.substr(0, index)) + nextChar + (text.substr(index + nextChar.length)));
    };
    this._step = function(sequence) {
      return times(this.settings.threads, (function(_this) {
        return function() {
          if (sequence.length === 0) {
            window.clearInterval(_this._interval);
            _this._trigger('complete');
            return;
          }
          return _this._replace(sequence);
        };
      })(this));
    };
    this.settings = $.extend(defaultSettings(), options);
    text = (_base = this.settings).text != null ? _base.text : _base.text = this.$element.text();
    if ($.type(this.settings.sequence) === 'string') {
      this.settings.sequence = SEQUENCES[this.settings.sequence](text);
    } else if ($.isFunction(this.settings.sequence)) {
      this.settings.sequence = this.settings.sequence(text);
    }
    sequenceClone = this.settings.sequence.slice(0);
    blankText = text.replace(BLANK_TEXT_REGEX, ' ');
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
    this._interval = window.setInterval((function(_this) {
      return function() {
        return _this._step(sequenceClone);
      };
    })(this), this.settings.milliseconds);
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
