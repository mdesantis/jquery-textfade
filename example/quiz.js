/*

abcd\nefg\nhijk
\ndcba
\ngfe
kjih


*/

var text = "abcd\nefg\n\nhijk\n"
var lines = text.match(/.+\n?|\n/g)

// Discard EOS ('') match
// [ 'abcd\n', 'efg\n', '\n', 'hijk\n' ]

var line, ch, seq = [], seqi

for (var i = 0; i < lines.length; i++) {
  line = lines[i]
  seqi = seq[i] = []
  for (var j = 0; j < line.length; j++) {
    ch = line[j]
    seqi.push()
  }
}

process.exit()


var text = "abcd\nefg\nhijk"
// ltr_btt
// "hijkefg\nabcd\n"
// [0,1 ,2 ,3 ,4,5,6,7,8,9,10,11,12]
// [[0,1,2,3,4],[5,6,7,8],[9,10,11,12]]
// [[9,10,11,12],[5,6,7,8],[0,1,2,3,4]]
// [9,10,11,12,5,6,7,8,0,1,2 ,3 ,4 ]


var lines = text.split("\n")
var c, i, j, line, ch, ti
c = 0

for (i = 0; i < lines.length; i++) {
  line = lines[i]
  for (j = 0; j < line.length; j++) {
    ch = line[j]
    ti = c+i
    console.log(ti, i)
    c++
  }
}


/*
var i = 0
while (i < string.length) {
  string[i]
  i++
}
*/