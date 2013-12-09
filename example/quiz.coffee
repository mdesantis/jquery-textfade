# abcd\nefg\nh
# 01234 5678 9
#
# \ndcba\ngfeh
# 4 32108 7659
# 
# ["abcd\n", "efg\n", "h"]
# [[0,1,2,3,4], [5,6,7,8], [9]]
# [[4,3,2,1,0], [8,7,6,5], [9]]

LINES_SPLIT_REGEX   = /.+\n?|\n/g

times = (n, fn) ->
  i   = 0
  fn ?= (i) -> i

  fn i++ while i < n

rtl_ttb = (text) ->
  seq = []
  c   = 0

  lines = text.match LINES_SPLIT_REGEX

  for line, i in lines
    seqi = seq[i] = []
    times line.length, () -> seqi.unshift c++
  
  seq.reduce (a, b) -> a.concat b


text = "abcd\nefg\nh"
# [4, 3, 2, 1, 0, 8, 7, 6, 5, 9]
console.log rtl_ttb text