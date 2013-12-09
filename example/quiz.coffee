shuffle = (array) ->
  i = array.length

  while i
    j = Math.floor Math.random()*i
    x = array[--i]
    array[i] = array[j]
    array[j] = x

  array

a = [0,1,2]
console.log shuffle(a)