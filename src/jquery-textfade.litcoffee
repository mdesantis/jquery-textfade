    ###!
    jQuery.TextFade v1.0.0
    https://github.com/mdesantis/jquery-textfade

    Copyright 2014-2018 Maurizio De Santis
    Released under the MIT license
    https://github.com/mdesantis/jquery-textfade/LICENSE
    ###

# jQuery.TextFade

## Description

**jQuery.TextFade** is a jQuery plugin which provides some nice fading effects to the contents of
the selected elements.

The fading effect is obtained replacing every character of the text with a blank character in the
case of a fade-out effect, and conversely replacing the text with blank characters and replacing
every blank character with the corresponding character in the text in the case of a fade-in effect.

If more elements are selected, their contents will be animated simultaneously.

## API

* **jQuery.textFade(action, options)**: main function
* **jQuery.textFadeIn(options)**: alias for `jQuery.textFade('in', options)`
* **jQuery.textFadeOut(options)**: alias for `jQuery.textFade('out', options)`

### Arguments

**jQuery.textFade** takes two arguments:
- **action**: the fading action; can be `'in'`, which causes the text to appear, or `'out'`, which
  causes the text to disappear. *Default value:* none
- **options**: the available options, which are:
  - **text**: if this option is specified, its value will replace the content of the selected
    element, so as to be used for the fading effect; otherwise the fading text is the content of the
    selected element. *Default value:* `null`
  - **sequence**: an array of characters indexes, which determine the order of the text fading.
    *Default value:* `'random'`. The value can be any of these types:
    - *array*: it will be iterated in sequence using each value as the index of the character to be
      replaced
    - *string*: it selects one between the preset sequences (more on this [below](#sequences))
    - *function*: it takes the fading text as argument and returns an array containing the
      characters indexes
  - **steps**: a step is the action of the character replacement. These are the available
    options:
    - **duration**: the duration of each character replacement in milliseconds. *Default value:
      `10`*
    - **threads**: the amount of character replacements for each step. *Default value:* `1`

**jQuery.textFadeIn** and **jQuery.textFadeOut** take the **options** argument only.


### Events

jQuery.textFade triggers two events, **start** and **stop**. In order to listen for them you can use
the following event identifiers:
- **start.textFadeIn**: start of a fade-in
- **stop.textFadeIn**: stop of a fade-in
- **start.textFadeOut**: start of a fade-out
- **stop.textFadeOut**: stop of a fade-out
- **start.textFade**: start of a fade of any action
- **stop.textFade**: stop of a fade of any action

In any case the action is passed as value of the `'action'` key of the first extra parameter, which
happens to be an object.

### Examples

- Fade out the text "HEY THERE!" one character every second:

```coffeescript
$('#text').textFadeIn({
  'text': 'HEY THERE!',
  'steps': { 'duration': 1000, 'threads': 1 }
})
```

- Fade out the text "SEE YA!" three characters every two seconds, in a
*left to right - top to bottom* order:

```coffeescript
$('#text').textFadeOut({
  'text': 'SEE YA!',
  'sequence': 'ltr_ttb',
  'steps': { 'duration': 2000, threads: 3 }
})
```

## Source

**TextFade** is the core function: in addition to the arguments described [above](#arguments), it
takes the `@$element` argument, that is the jQuery element/s whose text is going to be animated

    TextFade = (@$element, @action, options) ->

### Constants

      $                  = jQuery
      BLANK_TEXT_REGEXP  = /[^\n]/g
      LINES_SPLIT_REGEXP = /.+\n?|\n/g

#### Sequences

      SEQUENCES          =

`SEQUENCES` includes some preset sequences, selectable passing the corresponding identifier to
jQuery.textFade. The available identifiers are:

- **random**: the characters fading sequence is random

        'random'  : (text) -> shuffle times text.length

- **ltr_ttb** *(left-to-right character, top-to-bottom line)*: the text fading starts at the first
character of the first line, up to the end of line; then it moves to the next line

        'ltr_ttb' : (text) -> times text.length

- **ltr_btt** *(left-to-right character, bottom-to-top line)*: the text fading starts at the first
character of the last line, up to the end of line; then it moves to the previous line

        'ltr_btt' : (text) -> flatten (textToSequences text).reverse()

- **rtl_ttb** *(right-to-left character, top-to-bottom line)*: the text fading starts at the last
character of the first line, up to the start of line; then it moves to the next line

        'rtl_ttb' : (text) -> flatten textToSequences(text).map((v) -> v.reverse())

- **rtl_btt** *(right-to-left character, bottom-to-top line)*: the text fading starts at the last
character of the last line, up to the start of line; then it moves to the previous line

        'rtl_btt' : (text) -> flatten textToSequences(text).map((v) -> v.reverse()).reverse()

- **ttb_ltr** *(top-to-bottom character, left-to-right line)*: the text fading starts at the first
character of the first line, up to the first character of the last line; then it moves to the next
character of the first line

        'ttb_ltr' : (text) -> flatten zip textToSequences text

- **ttb_rtl** *(top-to-bottom character, right-to-left line)*: the text fading starts at the last
character of the first line, up to the last character of the last line; then it moves to the
previous character of the first line

        'ttb_rtl' : (text) -> flatten (zip textToSequences(text).reverse()).reverse()

- **btt_ltr** *(bottom-to-top character, left-to-right line)*: the text fading starts at the first
character of the last line, up to the first character of the first line; then it moves to the next
character of the last line

        'btt_ltr' : (text) -> flatten zip textToSequences(text).reverse()

- **btt_rtl** *(bottom-to-top character, right-to-left line)*: the text fading starts at the last
character of the last line, up to the first character of the last line; then it moves to the next
character of the last line

        'btt_rtl' : (text) -> flatten (zip textToSequences text).reverse()

### Utility functions

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

Take a text and return an array of arrays, each containing the text index of each
character of the corresponding line

      textToSequences = (text) ->
        sequences = []
        charIndex = 0
        lines     = text.match LINES_SPLIT_REGEXP

        for line, lineIndex in lines
          sequences[lineIndex] = []
          times line.length, () -> sequences[lineIndex].push charIndex++

        sequences

### Default options

      defaultOptions = ->
        'text'     : null
        'sequence' : 'random'
        'steps'    :
          'duration' : 10
          'threads'  : 1

### Private instance methods

Trigger both of the supported event namespaces

      @_trigger = (eventName) ->
        extraParameters = [{ 'action' : @action }]
        @$element.trigger "#{eventName}.textFade#{capitalize(@action)}", extraParameters
        @$element.trigger "#{eventName}.textFade", extraParameters

Replace the character at the given index

      @_replace = (index) ->
        text     = @$element.text()
        prevChar = @begText.charAt index
        nextChar = @endText.charAt index

The replacement is skipped if the character is the same

        return if prevChar is nextChar

        @$element.text "#{text.substr 0, index}#{nextChar}#{text.substr index+nextChar.length}"

The function executed for each character replacement, until the sequence gets empty

      @_step = (sequence) ->
        times @options.steps.threads, () =>
          return if sequence.length is 0

          @_replace sequence.shift()

        if sequence.length is 0
          clearInterval @_interval
          @_trigger 'stop'

### Constructor

      @options = $.extend true, defaultOptions(), options

      text = @options.text ? @$element.text()

      if $.type(@options.sequence) is 'string'
        @options.sequence = SEQUENCES[@options.sequence] text
      else if $.isFunction @options.sequence
        @options.sequence = @options.sequence text
      # else assert @options.sequence to be an array; leave it unchanged

Use an `@options.sequence` clone in order to keep it unchanged

      sequenceClone = @options.sequence[0..]

Newlines are preserved in order to preserve the text structure

      blankText = text.replace BLANK_TEXT_REGEXP, ' '

The only difference between fade-in and fade-out is that on fade-in we start with a blank text and
finish with the submitted text, while on fade-out we start with the submitted text and finish with
a blank text

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
      , @options.steps.duration

      @

### jQuery bindings

    $.fn.textFade = (action, options) ->
      @.each -> new TextFade $(@), action, options

    $.fn.textFadeIn = (options) ->
      @.textFade 'in', options

    $.fn.textFadeOut = (options) ->
      @.textFade 'out', options
