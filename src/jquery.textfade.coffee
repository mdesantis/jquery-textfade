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

  capitalize = (string) ->
    "#{string.charAt(0).toUpperCase()}#{string.slice(1)}"

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

  @_trigger = (event_type, action) ->
    @$element.trigger "#{event_type}.textFade#{capitalize(action)}"
    @$element.trigger "#{event_type}.textFade", [action]

  @_replace = (sequence) ->
    index     = sequence.shift()
    text      = @$element.text()
    character = @endText.charAt index

    @$element.text "#{text.substr 0, index}#{character}#{text.substr index+character.length}"

  @_step = (sequence) ->
    for i in [1..@settings.threads]
      if sequence.length == 0
        window.clearInterval @interval
        @_trigger 'complete', action
        return
      @_replace sequence

  @settings = $.extend defaultSettings(), options

  text                = @settings.text ?= @$element.text()
  @settings.sequence ?= randomSequence text.length
  # Use a clone of the original sequence in order to keep it unchanged
  sequenceClone       = @settings.sequence[0..]

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