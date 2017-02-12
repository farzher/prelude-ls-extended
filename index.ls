_ = require 'prelude-ls'




## Regex

# -> if /g => [matching-str*] else [(matching-str, group1, group2, ...)?]
_.regex-matches = (regex, str) -> str.match regex or []

# -> if not group? => [[matching-str, group1, group2, ...]*] else [str*]
_.regex-exec = (regex, str, group=null) -> while tmp = regex.exec str => if group? then tmp[group] else tmp









## List

# a https://github.com/gkz/LiveScript/issues/648
``_.a = function(){"use strict";for(var r=0|arguments.length,t=Array(r),n=0;r>n;n++)t[n]=arguments[n];return t}``

# [] -> []
_.clone = -> it.slice 0

# -> [int, int]
_.get2D = (i, width) -> [i % width, (Math.floor i / width)]

# -> int
_.get1D = (x, y, width) -> x + y * width

# -> []
# @mutate
_.shuffle = (arr) ->
  j = x = i = arr.length
  while i
    j = Math.floor Math.random! * i
    x = arr[--i]
    arr[i] = arr[j]
    arr[j] = x
  arr

# {}, [{}*] -> [{}*]
_.where = (query, arr) ->
  test = ->
    for k, v of query when it[k] isnt v => return false
    true
  [a for a in arr when test a]

# TODO: add some kind of group-map which allows you to map the grouped value (for mapping arrays to objects)

# -> [[]*]
_.batch = (count, list) ->
  count = Number count; if count < 1 => return []
  list = list.slice 0
  while list.length => list.splice 0, count

# -> bool
_.compare-arr = (arr1, arr2) ->
  return false if arr1.length isnt arr2.length
  for , k in arr1 => return false if arr1[k] isnt arr2[k]
  true

# -> bool
_.in = (x, arr) -> x in arr


## Math

# [num] -> num
_.variance = ->
  avg = _.mean it
  sum = 0; for v in it => x = v - avg; sum += x*x;
  sum / it.length

# [num] -> num
_.std-deviation = -> Math.sqrt _.variance it

# [num] -> [num*]
_.outside-std-deviation = (a, m=1) ->
  avg = _.mean a
  dev = _.std-deviation a
  for v in a when (Math.abs v - avg) > dev * m => v

# func, [mixed] -> [mixed*]
_.outside-std-deviation-by = (f, a, m=1) ->
  values = a |> _.map f
  avg = _.mean values
  dev = _.std-deviation values
  for v, k in a when (Math.abs values[k] - avg) > dev * m => v

# -> bool
_.chance = (num=0.5) -> Math.random! < num

# -> num
_.negate-if = (b, x) -> if b then -x else x

# -> bool
_.toggle-if = (b, v) -> if b then not v else v

# mixed -> int
_.to-bit = -> if it then 1 else 0

# -> int
_.rand = (min, max) -> Math.floor (Math.random! * (max - min + 1) + min)

# -> num
_.rand-float = (min, max) -> Math.random! * (max - min) + min

# [[item:mixed, weight:num]*] -> item
_.rand-weight = (arr, o=null) ->
  if o?invert
    max = -Infinity
    min = Infinity
    for [, weight] in arr
      if weight < min => min = weight
      if weight > max => max = weight
    max-plus-min = max + min
    arr = for a in arr => [a.0, max-plus-min - a.1]

  total = 0; for [, weight] in arr => total += weight

  rand = Math.random! * total
  current = 0
  for [value, weight] in arr
    current += weight
    return value if rand <= current

# -> num
_.map-number = (value, from1, from2, to1, to2, o=null) ->
  a-dist = from2 - from1
  b-dist = to2 - to1
  ratio = (value - from1) / a-dist
  if o?exponent
    is-negative = ratio < 0
    ratio = (Math.abs ratio) ^ o.exponent
    if is-negative => ratio = -ratio
  b-dist * ratio + to1


## Obj

_.import = Object.assign
_.new-obj = (...rest) -> Object.assign {}, ...rest








## List & Obj

# -> int or str
_.index-by = (f, item) ->
  if typeof! item is 'Object'
    list = _.values item
    target = f list
    for k, v of item when v is target => return k
  else
    target = f item
    for v, k in item when v is target => return k








## String

# -> bool
_.is-str = -> typeof! it is 'String'

# -> str
_.chr = (int) -> String.from-char-code int

# -> int
_.ord = (str) -> str.char-code-at 0

# -> bool
_.is-insensitive = (str1, str2) ->
  return false if typeof! str1 isnt 'String' or typeof! str2 isnt 'String'
  str1.to-upper-case! is str2.to-upper-case!

# -> bool
_.in-insensitive = (str, arr) ->
  return false if typeof! str isnt 'String'
  str = str.to-upper-case!
  for v in arr => return true if v.to-upper-case! is str
  false

# -> str
_.capitalize = (str) -> (str.substr 0, 1)toUpperCase! + str.substr 1







## Util

_.is-func = -> typeof! it is 'Function'
_.is-arr = -> typeof! it is 'Array'
_.is-obj = -> typeof! it is 'Object'
_.is-bool = -> typeof! it is 'Boolean'
_.is-num = -> typeof! it is 'Number' and !(isNan it)
_.is-promise = -> typeof! it.then is 'Function'
_.is-numeric = (n) -> !(isNaN +n) && isFinite n
_.is-numeric-int = (x) -> Number.isInteger (Number x)
# -> str
_.to-json = -> try JSON.stringify it
# -> mixed
# If there's any error, this returns undefined instead of throwing an error
_.json-parse = -> try JSON.parse it
_.from-json = _.json-parse # Alias, can't decide what name is better

# @usage on('resize', _.debounce(onResize, 100))
_.debounce = (func, wait, immediate) !->
  var timeout
  return !->
    context = @; args = arguments
    later = !->
      timeout := null
      if !immediate => func.apply context, args
    call-now = immediate and !timeout
    clearTimeout timeout
    timeout := setTimeout later, wait
    if call-now => func.apply context, args


_.flip-each = _.flip _.each
_.flip-map = _.flip _.map
_.flip-reject = _.flip _.reject
_.flip-filter = _.flip _.filter
_.flip-set-timeout = _.flip set-timeout

# Deprecated
_.is-array = _.is-arr
_.is-object = _.is-obj
_.compare-array = _.compare-arr
_.flip-if = _.toggle-if


module.exports = _
