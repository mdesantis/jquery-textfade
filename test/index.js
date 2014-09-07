$(document).ready(function() {
  var contents = $('#template').text()

  $.each(['i', 'o'], function(_, actionId) {
    for (var i = 1; i <= 13; i++) {
      var idI    = (i < 10 ? '0' : '')+i
      var id     = '#test'+idI+actionId
      var action = (actionId === 'i' ? 'In' : 'Out')

      $(id).on('start.textFade'+action, function(e) {
        console.log($(e.target).attr('id')+': '+e.namespace+' started')
      })

      $(id).on('stop.textFade'+action, function(e) {
        console.log($(e.target).attr('id')+': '+e.namespace+' stopped')
      })
    }
  })

  $('#test01i').textFadeIn({                   'step': { 'duration': 10               }                         })
  $('#test02i').textFadeIn({ 'text': contents, 'step': { 'duration': 10               }                         })
  $('#test03i').textFadeIn({ 'text': contents, 'step': { 'duration': 20               }                         })
  $('#test04i').textFadeIn({ 'text': contents, 'step': {                 'threads': 3 }                         })
  $('#test05i').textFadeIn({ 'text': contents, 'step': { 'duration': 200, 'threads': 3 }                         })
  $('#test06i').textFadeIn({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'ltr_ttb' })
  $('#test07i').textFadeIn({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'ltr_btt' })
  $('#test08i').textFadeIn({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'rtl_ttb' })
  $('#test09i').textFadeIn({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'rtl_btt' })
  $('#test10i').textFadeIn({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'ttb_ltr' })
  $('#test11i').textFadeIn({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'ttb_rtl' })
  $('#test12i').textFadeIn({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'btt_ltr' })
  $('#test13i').textFadeIn({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'btt_rtl' })

  $('#test01o').textFadeOut({                   'step': { 'duration': 10               }                         })
  $('#test02o').textFadeOut({ 'text': contents, 'step': { 'duration': 10               }                         })
  $('#test03o').textFadeOut({ 'text': contents, 'step': { 'duration': 20               }                         })
  $('#test04o').textFadeOut({ 'text': contents, 'step': {                 'threads': 3 }                         })
  $('#test05o').textFadeOut({ 'text': contents, 'step': { 'duration': 200, 'threads': 3 }                         })
  $('#test06o').textFadeOut({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'ltr_ttb' })
  $('#test07o').textFadeOut({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'ltr_btt' })
  $('#test08o').textFadeOut({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'rtl_ttb' })
  $('#test09o').textFadeOut({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'rtl_btt' })
  $('#test10o').textFadeOut({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'ttb_ltr' })
  $('#test11o').textFadeOut({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'ttb_rtl' })
  $('#test12o').textFadeOut({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'btt_ltr' })
  $('#test13o').textFadeOut({ 'text': contents, 'step': { 'duration': 10               },  'sequence': 'btt_rtl' })
})
