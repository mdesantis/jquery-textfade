text = "abcd\nefg\n\nhijk\n"
lines = text.match /.+\n?|\n/g

seq = []
c = 0

for line, i in lines
  seqi = seq[i] = []
  seqi.push c++ for j in [0..line.length-1]
    
seq.reverse().reduce((a, b) -> a.concat b)

process.exit()

# for (var i = 0; i < lines.length; i++) {
#   line = lines[i]
#   seqi = seq[i] = []
#   for (var j = 0; j < line.length; j++) {
#     ch = line[j]
#     seqi.push()
#   }
# }