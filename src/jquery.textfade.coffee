###!
jQuery.TextFade v 1.0.0.alpha
https://github.com/mdesantis/jquery.textfade

Copyright 2013 Maurizio De Santis
Released under the MIT license
https://github.com/mdesantis/jquery.textfade/LICENSE
###

# Coffeescript compile command: coffee --compile --output lib/ src/
# Uglify command:               uglifyjs lib/jquery.textfade.js --mangle --compress --comments '/!/' --output lib/jquery.textfade.min.js

# TODO sequenceTypes: random, ltr_ttb, ltr_btt, trl_ttb, trl_btt

$ = window.jQuery

TextFade = (@$element, action, options) ->

  BLANK_REPLACE_REGEX = /[^\n]/g
  LINES_SPLIT_REGEX   = /.+\n?|\n/g
  SEQUENCES           = 
    'random'  : (text) -> shuffle times text.length
    'ltr_ttb' : (text) -> times text.length
    'ltr_btt' : (text) ->
      sequence = textToSequence text, (seqi, c) -> seqi.push c
      sequence.reverse().reduce (a, b) -> a.concat b
    'rtl_ttb' : (text) ->
      sequence = textToSequence text, (seqi, c) -> seqi.unshift c
      sequence.reduce (a, b) -> a.concat b
    'rtl_btt' : (text) ->
      sequence = textToSequence text, (seqi, c) -> seqi.unshift c
      sequence.reverse().reduce (a, b) -> a.concat b

  textToSequence = (text, eachLineSequence) ->
    sequence = []
    count    = 0

    lines = text.match LINES_SPLIT_REGEX

    for line, i in lines
      lineSequence = sequence[i] = []
      times line.length, () ->
        eachLineSequence lineSequence, count
        count++

    sequence

  capitalize = (string) ->
    "#{string.charAt(0).toUpperCase()}#{string.slice(1)}"

  times = (n, fn) ->
    i   = 0
    fn ?= (i) -> i

    fn i++ while i < n

  shuffle = (array) ->
    i = array.length

    while i
      j = Math.floor Math.random()*i
      x = array[--i]
      array[i] = array[j]
      array[j] = x

    array

  defaultSettings = ->
    'text'         : null
    'milliseconds' : 1
    'threads'      : 1
    'sequence'     : 'random'

  @_trigger = (event_type, action) ->
    @$element.trigger "#{event_type}.textFade#{capitalize(action)}"
    @$element.trigger "#{event_type}.textFade", [action]

  @_replace = (sequence) ->
    index     = sequence.shift()
    text      = @$element.text()
    character = @endText.charAt index

    @$element.text "#{text.substr 0, index}#{character}#{text.substr index+character.length}"

  @_step = (sequence) ->
    times @settings.threads, () =>
      if sequence.length == 0
        window.clearInterval @interval
        @_trigger 'complete', action
        return
      @_replace sequence

  @settings = $.extend defaultSettings(), options

  text = @settings.text ?= @$element.text()

  if typeof @settings.sequence == 'string'
    @settings.sequence = SEQUENCES[@settings.sequence] text
  else if $.isFunction @settings.sequence
    @settings.sequence = @settings.sequence text
  # else assert @settings.sequence to be an array; leave it unchanged

  # Use a clone of @settings.sequence in order to keep it unchanged
  sequenceClone = @settings.sequence[0..]

  # Newlines are preserved in order to preserve the text structure
  blankText = text.replace BLANK_REPLACE_REGEX, ' '

  switch action
    when 'in'
      @begText = blankText
      @endText = text
    when 'out'
      @begText = text
      @endText = blankText

  @$element.text @begText

  @_trigger 'start', action

  @interval = window.setInterval =>
    @_step sequenceClone
  , @settings.milliseconds

  @

$.fn.textFadeIn = (options) ->
  @.each -> new TextFade $(@), 'in', options

$.fn.textFadeOut = (options) ->
  @.each -> new TextFade $(@), 'out', options

$.fn.textFade = (action, options) ->
  @.each -> new TextFade $(@), action, options