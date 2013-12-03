$(document).ready(function() {
  var contents = "\nABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\nABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\nABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\nABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\n\n";
  $('#test1').textFadeIn(          { 'milliseconds': 1  });
  $('#test2').textFadeIn(contents, { 'milliseconds': 1  });
  $('#test3').textFadeIn(contents, { 'milliseconds': 10 });
  $('#test4').textFadeIn(contents, { 'threads':      3  });
  $('#test5').textFadeIn(contents, {
    'milliseconds': 10,
    'threads': 3
  });
});
