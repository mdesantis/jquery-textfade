$(document).ready ->

  contents = """

  ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
  ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
  ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
  ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789


  """

  new window.TextFadeIn( document.getElementById('test1'),           'milliseconds': 1  ).run()
  new window.TextFadeIn( document.getElementById('test2'), contents, 'milliseconds': 1  ).run()
  new window.TextFadeIn( document.getElementById('test3'), contents, 'milliseconds': 10 ).run()
  new window.TextFadeIn( document.getElementById('test4'), contents, 'threads':      3  ).run()
  new window.TextFadeIn( document.getElementById('test5'), contents,
    'milliseconds': 10 , 
    'threads':      3  ).run()
