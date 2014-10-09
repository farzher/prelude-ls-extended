_ = require 'prelude-ls'




## Regex

# -> [str ...] or [empty]
_.regex-matches = (regex, str) -> str.match regex or []

# -> if not key? => [[str ...]] else [str ...]
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
	return arr

# -> []
_.where = (query, list) ->
	_.filter ->
		for k, v of query => return false if it[k] isnt v
		return true
	, list

# -> [[] ...] or [empty]
_.batch = (count, list) ->
	count = Number count; if count < 1 => return []
	list = list.slice 0
	return (while list.length => list.splice 0, count)

# [] -> Number
_.variance = ->
	avg = _.mean it
	sum = 0; for v in it => x = v - avg; sum += x*x;
	sum / it.length

# [] -> Number
_.std-deviation = -> Math.sqrt _.variance it

# [] -> []
_.in-std-deviation = (a, m=1) ->
	avg = _.mean a
	dev = _.std-deviation a
	for v in a when (Math.abs v - avg) > dev * m => v

# [] -> []
_.in-std-deviation-by = (f, a, m=1) ->
	values = a |> _.map f
	avg = _.mean values
	dev = _.std-deviation values
	for v, k in a when (Math.abs values[k] - avg) > dev * m => v






## Obj










## List & Obj

# -> int
_.index-by = (f, item) ->
	if _.is-type 'Object', item
		list = _.values item
		index = _.elem-index (f list), list
		return (_.keys item)[index]
	else return _.elem-index (f item), item




## Number

# -> int
_.rand = (min, max=null) ->
	[min, max] = [0, min] if not max?
	return Math.floor (Math.random! * (max - min + 1) + min)

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

# -> str
_.capitalize = (str) -> (str.substr 0, 1 .toUpperCase!) + str.substr 1







## Util

# -> bool
_.is-array = _.is-type 'Array'

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
