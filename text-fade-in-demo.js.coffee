$(document).ready ->

  assert = (condition) -> throw 'Assertion failed' unless condition

  contents = """

  #################################################################
  #################################################################
  #################################################################
  #################################################################


  """

  # assert contents == $('#sample').text()

  new window.TextFadeIn( $('#demo1'), contents, 'milliseconds': 1 ).run()
  new window.TextFadeIn( $('#demo2'),           'milliseconds': 1 ).run()

  # assert contents == $('#sample').text()
