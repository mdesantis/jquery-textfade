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
    'ltr_btt' : (text) ->
      sequences = textToSequences text
      sequences.reverse().reduce (p, c) -> p.concat c
    'rtl_ttb' : (text) ->
      sequences = textToSequences text, (lineSequence, charIndex) -> lineSequence.unshift charIndex
      sequences.reduce (p, c) -> p.concat c
    'rtl_btt' : (text) ->
      sequences = textToSequences text, (lineSequence, charIndex) -> lineSequence.unshift charIndex
      sequences.reverse().reduce (p, c) -> p.concat c
    'ttb_ltr' : (text) -> ttbBttSequence text, times, times
    'ttb_rtl' : (text) -> ttbBttSequence text, reversedTimes, reversedTimes
    'btt_ltr' : (text) -> ttbBttSequence text, times, reversedTimes
    'btt_rtl' : (text) -> ttbBttSequence text, reversedTimes, times

  ttbBttSequence = (text, iFn, jFn) ->
    sequence           = []
    sequences          = textToSequences text
    sequencesLength    = sequences.length
    maxSequencesLength = max $.map sequences, (v) -> v.length

    iFn maxSequencesLength, (i) ->
      jFn sequencesLength, (j) ->
        sequence.push sequences[j][i] if sequences[j][i]?

    sequence

  textToSequences = (text, eachLineSequence) ->
    sequences          = []
    charIndex         = 0
    lines             = text.match LINES_SPLIT_REGEX
    eachLineSequence ?= (lineSequence, charIndex) -> lineSequence.push charIndex

    for line, lineIndex in lines
      lineSequence = sequences[lineIndex] = []
      times line.length, () ->
        eachLineSequence lineSequence, charIndex
        charIndex++

    sequences

  capitalize = (string) -> "#{string.charAt(0).toUpperCase()}#{string.slice(1)}"

  max = (a) -> a.reduce ( (p, c) -> if c > p then c else p ), -Infinity

  times = (n, fn) ->
    i   = 0
    fn ?= (i) -> i

    fn i++ while i < n

  reversedTimes = (n, fn) ->
    i   = n-1
    fn ?= (i) -> i

    fn i-- while i >= 0

  shuffle = (array) ->
    i = array.length

    while i
      j = Math.floor Math.random()*i
      x = array[--i]
      array[i] = array[j]
      array[j] = x

    array

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

    return if prevChar == nextChar # no need to replace; skip

    @$element.text "#{text.substr 0, index}#{nextChar}#{text.substr index+nextChar.length}"

  @_step = (sequence) ->
    times @settings.threads, () =>
      if sequence.length == 0
        window.clearInterval @_interval
        @_trigger 'complete'
        return
      @_replace sequence

  @settings = $.extend defaultSettings(), options

  text = @settings.text ?= @$element.text()

  if $.type(@settings.sequence) == 'string'
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
