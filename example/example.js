$(document).ready(function() {

  var contents = $('#sample').text()
  
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
  $('#test1i').textFadeIn({                   'milliseconds': 10                        })
  $('#test2i').textFadeIn({ 'text': contents, 'milliseconds': 10                        })
  $('#test3i').textFadeIn({ 'text': contents, 'milliseconds': 10                        })
  $('#test4i').textFadeIn({ 'text': contents, 'threads':      3                         })
  $('#test5i').textFadeIn({ 'text': contents,
    'milliseconds': 20,
    'threads': 3
  })
  $('#test6i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_ttb' })
  $('#test7i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_btt' })
  $('#test8i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_ttb' })
  $('#test9i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_btt' })

  $('#test1o').textFadeOut({                   'milliseconds': 10                        })
  $('#test2o').textFadeOut({ 'text': contents, 'milliseconds': 10                        })
  $('#test3o').textFadeOut({ 'text': contents, 'milliseconds': 10                        })
  $('#test4o').textFadeOut({ 'text': contents, 'threads':      3                         })
  $('#test5o').textFadeOut({ 'text': contents,
    'milliseconds': 20,
    'threads': 3
  })
  $('#test6o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_ttb' })
  $('#test7o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_btt' })
  $('#test8o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_ttb' })
  $('#test9o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_btt' })

})
