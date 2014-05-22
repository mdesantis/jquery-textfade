###!
jQuery.TextFade v 1.0.0
https://github.com/mdesantis/jquery.textfade

Copyright 2014 Maurizio De Santis
Released under the MIT license
https://github.com/mdesantis/jquery.textfade/LICENSE
###

TextFade = (@$element, @action, options) ->
  $                   = window.jQuery
  BLANK_TEXT_REGEX    = /[^\n]/g
  LINES_SPLIT_REGEX   = /.+\n?|\n/g
  SEQUENCES           =
    'random'  : (text) -> shuffle times text.length
    'ltr_ttb' : (text) -> times text.length
    'ltr_btt' : (text) -> flatten (textToSequences text).reverse()
    'rtl_ttb' : (text) -> flatten textToSequences(text).map((v) -> v.reverse())
    'rtl_btt' : (text) -> flatten textToSequences(text).map((v) -> v.reverse()).reverse()
    'ttb_ltr' : (text) -> flatten zip textToSequences text
    'ttb_rtl' : (text) -> flatten (zip textToSequences(text).reverse()).reverse()
    'btt_ltr' : (text) -> flatten zip textToSequences(text).reverse()
    'btt_rtl' : (text) -> flatten (zip textToSequences text).reverse()

  capitalize = (s) -> "#{s.charAt(0).toUpperCase()}#{s.slice(1)}"

  flatten = (a) -> a.reduce (p, c) -> p.concat c

  max = (a) -> a.reduce ((p, c) -> Math.max p, c), -Infinity

  shuffle = (a) ->
    i = a.length

    while i
      j = Math.floor Math.random()*i
      x = a[--i]
      a[i] = a[j]
      a[j] = x

    a

  times = (n, fn) ->
    i   = 0
    fn ?= (i) -> i

    fn i++ while i < n

  zip = (a) ->
    result = []

    times (max a.map (v) -> v.length), (i) ->
      for v in a
        (result[i] ?= []).push v[i] if v[i]?

    result

  textToSequences = (text) ->
    sequences = []
    charIndex = 0
    lines     = text.match LINES_SPLIT_REGEX

    for line, lineIndex in lines
      sequences[lineIndex] = []
      times line.length, () -> sequences[lineIndex].push charIndex++

    sequences

  defaultSettings = ->
    'milliseconds' : 1
    'sequence'     : 'random'
    'text'         : null
    'threads'      : 1

  @_trigger = (event_type, extraParameters) ->
    extraParameters ?= []

    @$element.trigger "#{event_type}.textFade#{capitalize(@action)}", extraParameters
    @$element.trigger "#{event_type}.textFade", extraParameters.unshift(@action)

  @_replace = (sequence) ->
    index    = sequence.shift()
    text     = @$element.text()
    prevChar = @begText.charAt index
    nextChar = @endText.charAt index

    return if prevChar is nextChar # no need to replace; skip

    @$element.text "#{text.substr 0, index}#{nextChar}#{text.substr index+nextChar.length}"

  @_step = (sequence) ->
    times @settings.threads, () =>
      if sequence.length is 0
        window.clearInterval @_interval
        @_trigger 'complete'
        return
      @_replace sequence

  @settings = $.extend defaultSettings(), options

  text = @settings.text ? @$element.text()

  if $.type(@settings.sequence) is 'string'
    @settings.sequence = SEQUENCES[@settings.sequence] text
  else if $.isFunction @settings.sequence
    @settings.sequence = @settings.sequence text
  # else assert @settings.sequence to be an array; leave it unchanged

  # Use a clone of @settings.sequence in order to keep it unchanged
  sequenceClone = @settings.sequence[0..]

  # Newlines are preserved in order to preserve the text structure
  blankText = text.replace BLANK_TEXT_REGEX, ' '

  switch @action
    when 'in'
      @begText = blankText
      @endText = text
    when 'out'
      @begText = text
      @endText = blankText

  @$element.text @begText

  @_trigger 'start'

  @_interval = window.setInterval =>
    @_step sequenceClone
  , @settings.milliseconds

  @

$.fn.textFade = (action, options) ->
  @.each -> new TextFade $(@), action, options

$.fn.textFadeIn = (options) ->
  @.textFade 'in', options

$.fn.textFadeOut = (options) ->
  @.textFade 'out', options
