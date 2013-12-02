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

  BLANK_REPLACE_REGEX = /[^\n]/g

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

  replace = (element, text, sequence) ->
    index     = sequence.shift()
    prev_text = getText element
    character = text.charAt(index)

    setText element, "#{prev_text.substr(0, index)}#{character}#{prev_text.substr(index+character.length)}"

  # References: Sizzle.getText
  getText = (element) ->
    text     = ''
    nodeType = element.nodeType

    unless nodeType
      text += getText node for node in element
    else if nodeType == 1 or nodeType == 9 or nodeType == 11
      if typeof element.textContent == 'string'
        return element.textContent
      else
        if element = element.firstChild
          text += getText element
          text += getText element while element = element.nextSibling
    else if nodeType == 3 or nodeType == 4
      return element.nodeValue

    text

  setText = (element, value) ->
    element.removeChild element.lastChild while element.hasChildNodes()
    element.appendChild element.ownerDocument.createTextNode value

  step = (element, text, sequence, threads, interval, complete) ->
    for i in [1..threads]
      if sequence.length == 0
        window.clearInterval interval
        complete?()
        return true
      replace element, text, sequence

  constructor: (@element, text, options) ->
    if options?
      @text = text ? getText @element
    else
      if typeof text == 'object'
        @text   = getText @element
        options = text
      else
        @text    = text ? getText @element
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
    setText @element, blankText

    interval = window.setInterval =>
      step @element, @text, sequenceClone, @threads, interval, @complete
    , @milliseconds

    true

window.TextFadeIn = TextFadeIn