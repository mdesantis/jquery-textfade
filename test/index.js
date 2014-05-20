$(document).ready(function() {
  var contents = $('#template').text()
  
  // $('#test1i').on('start.textFade', function(e, action) {
  //   // console.log(e.type+'.'+e.namespace, e, action)
  // })
  // $('#test1i').on('start.textFadeIn', function(e) {
  //   // console.log(e.type+'.'+e.namespace, e)
  // })
  // $('#test1i').on('complete.textFade', function(e, action) {
  //   // console.log(e.type+'.'+e.namespace, e, action)
  // })
  // $('#test1i').on('complete.textFadeIn', function(e) {
  //   // console.log(e.type+'.'+e.namespace, e)
  // })
  // $('#test1i').on('replace.textFadeIn', function(e, prevChar, nextChar) {
  //   // console.log(e.type+'.'+e.namespace, e, prevChar, nextChar)
  //   // console.log("Replacing " + JSON.stringify(prevChar) + " with " + JSON.stringify(nextChar))
  // })
  $('#test01i').textFadeIn({                   'milliseconds': 10                        })
  $('#test02i').textFadeIn({ 'text': contents, 'milliseconds': 10                        })
  $('#test03i').textFadeIn({ 'text': contents, 'milliseconds': 10                        })
  $('#test04i').textFadeIn({ 'text': contents, 'threads':      3                         })
  $('#test05i').textFadeIn({ 'text': contents,
    'milliseconds': 20,
    'threads': 3
  })
  $('#test06i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_ttb' })
  $('#test07i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_btt' })
  $('#test08i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_ttb' })
  $('#test09i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_btt' })
  $('#test10i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ttb_ltr' })
  $('#test11i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ttb_rtl' })
  $('#test12i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'btt_ltr' })
  $('#test13i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'btt_rtl' })

  $('#test01o').textFadeOut({                   'milliseconds': 10                        })
  $('#test02o').textFadeOut({ 'text': contents, 'milliseconds': 10                        })
  $('#test03o').textFadeOut({ 'text': contents, 'milliseconds': 10                        })
  $('#test04o').textFadeOut({ 'text': contents, 'threads':      3                         })
  $('#test05o').textFadeOut({ 'text': contents,
    'milliseconds': 20,
    'threads': 3
  })
  $('#test06o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_ttb' })
  $('#test07o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_btt' })
  $('#test08o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_ttb' })
  $('#test09o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_btt' })
  $('#test10o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ttb_ltr' })
  $('#test11o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ttb_rtl' })
  $('#test12o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'btt_ltr' })
  $('#test13o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'btt_rtl' })
})
