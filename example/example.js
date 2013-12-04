$(document).ready(function() {

  var contents = $('#sample').text()
  
  $('#test1i').textFadeIn({                   'milliseconds': 1  })
  $('#test1i').on('start.textFade', function(e, action) {
    console.log(e.type+'.'+e.namespace, e, action)
  })
  $('#test1i').on('start.textFadeIn', function(e) {
    console.log(e.type+'.'+e.namespace, e)
  })
  $('#test1i').on('complete.textFade', function(e, action) {
    console.log(e.type+'.'+e.namespace, e, action)
  })
  $('#test1i').on('complete.textFadeIn', function(e) {
    console.log(e.type+'.'+e.namespace, e)
  })
  $('#test2i').textFadeIn({ 'text': contents, 'milliseconds': 1  })
  $('#test3i').textFadeIn({ 'text': contents, 'milliseconds': 10 })
  $('#test4i').textFadeIn({ 'text': contents, 'threads':      3  })
  $('#test5i').textFadeIn({ 'text': contents,
    'milliseconds': 10,
    'threads': 3
  })

  $('#test1o').textFadeOut({                   'milliseconds': 1  })
  $('#test2o').textFadeOut({ 'text': contents, 'milliseconds': 1  })
  $('#test3o').textFadeOut({ 'text': contents, 'milliseconds': 10 })
  $('#test4o').textFadeOut({ 'text': contents, 'threads':      3  })
  $('#test5o').textFadeOut({ 'text': contents,
    'milliseconds': 10,
    'threads': 3
  })

})
