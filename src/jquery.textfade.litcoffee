    ###!
    jQuery.TextFade v1.0.0
    https://github.com/mdesantis/jquery.textfade

    Copyright 2014 Maurizio De Santis
    Released under the MIT license
    https://github.com/mdesantis/jquery.textfade/LICENSE
    ###

# jQuery.TextFade

**jQuery.TextFade** is a jQuery plugin which provides some nice fading effects to the contents of
the selected elements.

## Description

The fading effect is obtained replacing every character of the text with a blank character
in the case of a fade-out effect, and conversely replacing the text with blank characters and
replacing every blank character with the corresponding character in the text in the case of a
fade-in effect.

## Source

**TextFade** is the core function; it takes three arguments:

- **@$element**: the jQuery element/s whose text will be animated. If more elements are selected,
  their content will be animated simultaneously
- **@action**: the fading action; can be `'in'`, which causes the text to appear, or `'out'`, which
  causes the text to disappear
- **options**: the available options, which are:
    - **text**: if this option is specified, its value will replace the content of the selected
      element, so as to be used for the fading effect; otherwise the fading text is taken from the
      selected element content
    - **sequence**: an array of characters indexes, which determine the order of the text fading.
      The option can be:
        - an array: it will be iterated using each value as the characters index sequentially
        - a string: one between `random`, `ltr_ttb`, `ltr_btt`, `rtl_ttb`, `rtl_btt`, `ttb_ltr`,
          `ttb_rtl`, `btt_ltr`, `btt_rtl`; it selects one between the preset sequences. More on this
          [below](#preset-sequences)
        - a function: it takes the fading text as argument and returns an array containing the
          characters indexes
    - **milliseconds**:
    - **threads**:

<!-- Markdown list clearing hack -->

    TextFade = (@$element, @action, options) ->
      $                   = jQuery
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

      defaultOptions = ->
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
        times @options.threads, () =>
          if sequence.length is 0
            clearInterval @_interval
            @_trigger 'complete'
            return
          @_replace sequence

      @options = $.extend defaultOptions(), options

      text = @options.text ? @$element.text()

      if $.type(@options.sequence) is 'string'
        @options.sequence = SEQUENCES[@options.sequence] text
      else if $.isFunction @options.sequence
        @options.sequence = @options.sequence text
      # else assert @options.sequence to be an array; leave it unchanged

      # Use a clone of @options.sequence in order to keep it unchanged
      sequenceClone = @options.sequence[0..]

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

      @_interval = setInterval =>
        @_step sequenceClone
      , @options.milliseconds

      @

    $.fn.textFade = (action, options) ->
      @.each -> new TextFade $(@), action, options

    $.fn.textFadeIn = (options) ->
      @.textFade 'in', options

    $.fn.textFadeOut = (options) ->
      @.textFade 'out', options
