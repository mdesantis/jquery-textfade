###
TextFadeIn v 1.0.0
https://github.com/mdesantis/TextFadeIn

Includes parts of Sizzle.js
http://sizzlejs.com/

Copyright 2013 Maurizio De Santis
Released under the MIT license
https://github.com/mdesantis/TextFadeIn/LICENSE
###
class TextFadeIn

  `
  var shuffle = function(a) {
    for(var j, x, i = a.length; i; j = Math.floor(Math.random() * i), x = a[--i], a[i] = a[j], a[j] = x);
    return a;
  }
  `
  randomSequence = (length) ->
    sequence = []
    sequence.push(i) for i in [0..length]
    shuffle sequence

  replace = ($element, text, sequence) ->
    index     = sequence.shift()
    prev_text = $element.text()
    character = text.charAt(index)

    $element.text "#{prev_text.substr(0, index)}#{character}#{prev_text.substr(index+character.length)}"

  step = ($element, text, sequence, threads, interval, complete) ->
    for i in [1..threads]
      if sequence.length == 0
        window.clearInterval interval
        complete?()
        return true
      replace $element, text, sequence

  constructor: (@$element, text, options) ->
    if options?
      @text = text ? @$element.text()
    else
      if $.isPlainObject text
        @text   = @$element.text()
        options = text
      else
        @text    = text ? @$element.text()
        options  = {}

    @milliseconds  = options['milliseconds'] ? 1
    @threads       = options['threads']      ? 1
    @sequence      = options['sequence']
    @start         = options['start']
    @complete      = options['complete']

  run: () ->
    @sequence     ?= randomSequence @text.length
    # Maintain a reference of the sequence used
    sequenceClone  = @sequence.slice 0

    # New lines are preserved in order to preserve the text structure
    blankText = @text.replace /[^\n]/g, ' '
    @$element.text blankText

    interval = window.setInterval =>
      step @$element, @text, sequenceClone, @threads, interval, @complete
    , @milliseconds

    true

window.TextFadeIn = TextFadeIn