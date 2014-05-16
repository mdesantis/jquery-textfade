$(document).ready(function() {
  var contents = $('#template').text()
  
  // $('#sample1i').on('start.textFade', function(e, action) {
  //   // console.log(e.type+'.'+e.namespace, e, action)
  // })
  // $('#sample1i').on('start.textFadeIn', function(e) {
  //   // console.log(e.type+'.'+e.namespace, e)
  // })
  // $('#sample1i').on('complete.textFade', function(e, action) {
  //   // console.log(e.type+'.'+e.namespace, e, action)
  // })
  // $('#sample1i').on('complete.textFadeIn', function(e) {
  //   // console.log(e.type+'.'+e.namespace, e)
  // })
  // $('#sample1i').on('replace.textFadeIn', function(e, prevChar, nextChar) {
  //   // console.log(e.type+'.'+e.namespace, e, prevChar, nextChar)
  //   // console.log("Replacing " + JSON.stringify(prevChar) + " with " + JSON.stringify(nextChar))
  // })
  $('#sample01i').textFadeIn({                   'milliseconds': 10                        })
  $('#sample02i').textFadeIn({ 'text': contents, 'milliseconds': 10                        })
  $('#sample03i').textFadeIn({ 'text': contents, 'milliseconds': 10                        })
  $('#sample04i').textFadeIn({ 'text': contents, 'threads':      3                         })
  $('#sample05i').textFadeIn({ 'text': contents,
    'milliseconds': 20,
    'threads': 3
  })
  $('#sample06i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_ttb' })
  $('#sample07i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_btt' })
  $('#sample08i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_ttb' })
  $('#sample09i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_btt' })
  $('#sample10i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ttb_ltr' })
  $('#sample11i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'ttb_rtl' })
  $('#sample12i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'btt_ltr' })
  $('#sample13i').textFadeIn({ 'text': contents, 'milliseconds': 10,  'sequence': 'btt_rtl' })

  $('#sample01o').textFadeOut({                   'milliseconds': 10                        })
  $('#sample02o').textFadeOut({ 'text': contents, 'milliseconds': 10                        })
  $('#sample03o').textFadeOut({ 'text': contents, 'milliseconds': 10                        })
  $('#sample04o').textFadeOut({ 'text': contents, 'threads':      3                         })
  $('#sample05o').textFadeOut({ 'text': contents,
    'milliseconds': 20,
    'threads': 3
  })
  $('#sample06o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_ttb' })
  $('#sample07o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ltr_btt' })
  $('#sample08o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_ttb' })
  $('#sample09o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'rtl_btt' })
  $('#sample10o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ttb_ltr' })
  $('#sample11o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'ttb_rtl' })
  $('#sample12o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'btt_ltr' })
  $('#sample13o').textFadeOut({ 'text': contents, 'milliseconds': 10,  'sequence': 'btt_rtl' })
})
