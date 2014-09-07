$(document).ready(function() {
  var contents = $('#template').text()

  $.each(['i', 'o'], function(_, actionId) {
    for (var i = 1; i <= 14; i++) {
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

  $('#test01i').textFadeIn({                   'steps': { 'duration': 10                }                         })
  $('#test02i').textFadeIn({ 'text': contents, 'steps': { 'duration': 10                }                         })
  $('#test03i').textFadeIn({ 'text': contents, 'steps': { 'duration': 20                }                         })
  $('#test04i').textFadeIn({ 'text': contents, 'steps': {                  'threads': 3 }                         })
  $('#test05i').textFadeIn({ 'text': contents, 'steps': { 'duration': 100, 'threads': 6 }                         })
  $('#test06i').textFadeIn({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'ltr_ttb' })
  $('#test07i').textFadeIn({ 'text': contents, 'steps': { 'duration': 100, 'threads': 6 },  'sequence': 'ltr_ttb' })
  $('#test08i').textFadeIn({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'ltr_btt' })
  $('#test09i').textFadeIn({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'rtl_ttb' })
  $('#test10i').textFadeIn({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'rtl_btt' })
  $('#test11i').textFadeIn({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'ttb_ltr' })
  $('#test12i').textFadeIn({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'ttb_rtl' })
  $('#test13i').textFadeIn({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'btt_ltr' })
  $('#test14i').textFadeIn({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'btt_rtl' })

  $('#test01o').textFadeOut({                   'steps': { 'duration': 10                }                         })
  $('#test02o').textFadeOut({ 'text': contents, 'steps': { 'duration': 10                }                         })
  $('#test03o').textFadeOut({ 'text': contents, 'steps': { 'duration': 20                }                         })
  $('#test04o').textFadeOut({ 'text': contents, 'steps': {                  'threads': 3 }                         })
  $('#test05o').textFadeOut({ 'text': contents, 'steps': { 'duration': 100, 'threads': 6 }                         })
  $('#test06o').textFadeOut({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'ltr_ttb' })
  $('#test07o').textFadeOut({ 'text': contents, 'steps': { 'duration': 100, 'threads': 6 },  'sequence': 'ltr_ttb' })
  $('#test08o').textFadeOut({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'ltr_btt' })
  $('#test09o').textFadeOut({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'rtl_ttb' })
  $('#test10o').textFadeOut({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'rtl_btt' })
  $('#test11o').textFadeOut({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'ttb_ltr' })
  $('#test12o').textFadeOut({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'ttb_rtl' })
  $('#test13o').textFadeOut({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'btt_ltr' })
  $('#test14o').textFadeOut({ 'text': contents, 'steps': { 'duration': 10                },  'sequence': 'btt_rtl' })
})
