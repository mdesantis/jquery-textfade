###!
TextFadeIn v 1.0.0
https://github.com/mdesantis/TextFadeIn

Copyright 2013 Maurizio De Santis
Released under the MIT license
https://github.com/mdesantis/TextFadeIn/LICENSE
###

# Coffeescript compile command: coffee --compile --output lib/ src/
# Uglify command:               uglifyjs lib/text-fade-in.js --mangle --compress --comments '/!/' --output lib/text-fade-in.min.js

# TODO sequenceTypes: random, ltr_ttb, ltr_btt, trl_ttb, trl_btt

$ = window.jQuery

TextFade = (@$element, action, options) ->

  BLANK_REPLACE_REGEX = /[^\n]/g

  shuffle = (a) ->
    i = a.length

    while i
      j = Math.floor Math.random()*i
      x = a[--i]
      a[i] = a[j]
      a[j] = x

    a

  randomSequence = (length) -> shuffle [0..length]

  defaultSettings = ->
    'text':         null
    'milliseconds': 1
    'threads':      1
    'sequence':     null
    'start':        null
    'complete':     null

  @_replace = (sequence) ->
    index     = sequence.shift()
    prev_text = @$element.text()
    character = @endText.charAt index

    @$element.text "#{prev_text.substr 0, index}#{character}#{prev_text.substr index+character.length}"

  @_step = (sequence) ->
    for i in [1..@settings.threads]
      if sequence.length == 0
        window.clearInterval @interval
        return @settings.complete?()
      @_replace sequence

  @settings = $.extend defaultSettings(), options

  # Not used at the moment
  # @start         = settings['start']

  text                = @settings.text ?= @$element.text()
  @settings.sequence ?= randomSequence text.length
  # Use a copy of the sequence used in order to keep the original one
  sequenceClone       = @settings.sequence[0..]

  # New lines are preserved in order to preserve the text structure
  blankText = text.replace BLANK_REPLACE_REGEX, ' '

  switch action
    when 'in'
      @begText = blankText
      @endText = text
    when 'out'
      @begText = text
      @endText = blankText

  @$element.text @begText

  @interval = window.setInterval =>
    @_step sequenceClone
  , @settings.milliseconds

  @

$.fn.textFadeIn = (options) ->
  @.each ->
    new TextFade $(@), 'in', options

$.fn.textFadeOut = (options) ->
  @.each ->
    new TextFade $(@), 'out', options
