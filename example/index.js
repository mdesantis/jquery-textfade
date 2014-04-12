$(document).ready(function() {

  var contents = $('#template').text()
  
  $('#sample1i').on('start.textFade', function(e, action) {
    console.log(e.type+'.'+e.namespace, e, action)
  })
  $('#sample1i').on('start.textFadeIn', function(e) {
    console.log(e.type+'.'+e.namespace, e)
  })
  $('#sample1i').on('complete.textFade', function(e, action) {
    console.log(e.type+'.'+e.namespace, e, action)
  })
  $('#sample1i').on('complete.textFadeIn', function(e) {
    console.log(e.type+'.'+e.namespace, e)
  })
  $('#sample1i').on('replace.textFadeIn', function(e, prevChar, nextChar) {
    console.log(e.type+'.'+e.namespace, e, prevChar, nextChar)
    //console.log("Replacing " + JSON.stringify(prevChar) + " with " + JSON.stringify(nextChar))
  })
  $('#sample1i').textFadeIn({                   'milliseconds': 10                        })
  $('#sample2i').textFadeIn({ 'text': contents, 'milliseconds': 10                        })
  $('#sample3i').textFadeIn({ 'text': contents, 'milliseconds': 10                        })
  $('#sample4i').textFadeIn({ 'text': contents, 'threads':      3                         })
  $('#sample5i').textFadeIn({ 'text': contents,
    'milliseconds': 20,
    'threads': 3
  })
  $('#sample6i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_ttb' })
  $('#sample7i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_btt' })
  $('#sample8i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_ttb' })
  $('#sample9i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_btt' })

  $('#sample1o').textFadeOut({                   'milliseconds': 10                        })
  $('#sample2o').textFadeOut({ 'text': contents, 'milliseconds': 10                        })
  $('#sample3o').textFadeOut({ 'text': contents, 'milliseconds': 10                        })
  $('#sample4o').textFadeOut({ 'text': contents, 'threads':      3                         })
  $('#sample5o').textFadeOut({ 'text': contents,
    'milliseconds': 20,
    'threads': 3
  })
  $('#sample6o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_ttb' })
  $('#sample7o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_btt' })
  $('#sample8o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_ttb' })
  $('#sample9o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_btt' })

})
