###!
TextFadeIn v 1.0.0
https://github.com/mdesantis/TextFadeIn

Includes parts of Sizzle.js
http://sizzlejs.com/

Copyright 2013 Maurizio De Santis
Released under the MIT license
https://github.com/mdesantis/TextFadeIn/LICENSE
###

# Coffeescript compile command: coffee --compile --output lib/ src/
# Uglify command:               uglifyjs lib/text-fade-in.js --mangle --compress --comments '/!/' --output lib/text-fade-in.min.js
class TextFadeIn

  BLANK_REPLACE_REGEX = /[^\n]/g
  asd = 'ciao'

  shuffle = (a) ->
    i = a.length

    while i
      j = Math.floor Math.random()*i
      x = a[--i]
      a[i] = a[j]
      a[j] = x

    a

  randomSequence = (length) -> shuffle [0..length]

  replace = ($element, text, sequence) ->
    index     = sequence.shift()
    prev_text = $element.text()
    character = text.charAt index

    $element.text "#{prev_text.substr 0, index}#{character}#{prev_text.substr index+character.length}"

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
    # Use a copy of the sequence used in order to keep the original one
    sequenceClone  = @sequence[0..]

    # New lines are preserved in order to preserve the text structure
    blankText = @text.replace BLANK_REPLACE_REGEX, ' '
    @$element.text blankText

    interval = window.setInterval =>
      step @$element, @text, sequenceClone, @threads, interval, @complete
    , @milliseconds

    true

window.TextFadeIn = TextFadeIn