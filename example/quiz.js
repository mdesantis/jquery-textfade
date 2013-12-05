var text = "abcd\nefg\nhijk"
// ltr_btt
// "hijkefg\nabcd\n"
// [9,10,11,12,5,6,7,8,0,1,2 ,3 ,4 ]
// [0,1 ,2 ,3 ,4,5,6,7,8,9,10,11,12]


var lines = text.split("\n")
var c, i, j, line, ch, ti;
c = 0;

for (i = 0; i < lines.length; i++) {
  line = lines[i]
  for (j = 0; j < line.length; j++) {
    ch = line[j]
    ti = c+i
    console.log(ti, i)
    c++;
  }
}


/*
var i = 0
while (i < string.length) {
  string[i]
  i++
}
*/