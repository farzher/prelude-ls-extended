_ = require 'prelude-ls'




## Regex

# -> [str*]
_.regex-matches = (regex, str) -> str.match regex or []

# -> if not key? => [[str+]*] else [str*]
_.regex-exec = (regex, str, key=null) -> while tmp = regex.exec str => if key? then tmp[key] else tmp









## List

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

# -> [[]*]
_.batch = (count, list) ->
	count = Number count; if count < 1 => return []
	list = list.slice 0
	while list.length => list.splice 0, count

# [num] -> Number
_.variance = ->
	avg = _.mean it
	sum = 0; for v in it => x = v - avg; sum += x*x;
	sum / it.length

# [num] -> Number
_.std-deviation = -> Math.sqrt _.variance it

# [num] -> [num*]
_.outside-std-deviation = (a, m=1) ->
	avg = _.mean a
	dev = _.std-deviation a
	for v in a when (Math.abs v - avg) > dev * m => v

# [mixed] -> [mixed*]
_.outside-std-deviation-by = (f, a, m=1) ->
	values = a |> _.map f
	avg = _.mean values
	dev = _.std-deviation values
	for v, k in a when (Math.abs values[k] - avg) > dev * m => v






## Obj










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




## Number

# -> int
_.rand = (min, max=null) ->
	[min, max] = [0, min] if not max?
	Math.floor (Math.random! * (max - min + 1) + min)

# -> bool
_.chance = (num=0.5) -> Math.random! < num

# -> num
_.negate-if = (b, x) -> if b then -x else x









## String

# -> str
_.chr = (int) -> String.from-char-code int

# -> int
_.ord = (str) -> str.char-code-at 0

# -> bool
_.is-insensitive = (a, b) -> a.to-upper-case! is b.to-upper-case!

# -> bool
_.in-insensitive = (a, arr) ->
	a = a.to-upper-case!
	for v in arr => return true if v.to-upper-case! is a
	false

# -> bool
_.compare-array = (a, b) ->
	return false if a.length isnt b.length
	for , k in a => return false if a[k] isnt b[k]
	true

# -> str
_.capitalize = (str) -> (str.substr 0, 1)toUpperCase! + str.substr 1







## Util

# -> bool
_.is-array = -> typeof! it is 'Array'

# -> int
_.bool-to-int = (b) -> if b then 1 else 0




_.flip-each = _.flip _.each
_.flip-map = _.flip _.map
_.flip-reject = _.flip _.reject
_.flip-filter = _.flip _.filter
_.flip-set-timeout = _.flip _.set-timeout

# Depreciated
_.regex-match = (regex, str) -> str.match regex or []

module.exports = _
