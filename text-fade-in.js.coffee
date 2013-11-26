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

  step = ($element, text, sequence, threads, interval) ->
    for i in [1..threads]
      if sequence.length == 0
        window.clearInterval interval
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

  run: () ->
    @sequence     ?= randomSequence @text.length
    sequenceClone  = @sequence.slice 0           # needed in order to maintain a reference of the sequence used

    blankText = @text.replace /[^\n]/g, ' '
    @$element.text blankText

    interval = window.setInterval =>
      step @$element, @text, sequenceClone, @threads, interval
    , @milliseconds

    true

window.TextFadeIn = TextFadeIn