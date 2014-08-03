_ = require 'prelude-ls'




## Regex

# -> []
_.regex-match = (regex, str) -> str.match regex or []

# -> []
_.regex-exec = (regex, str, key=null) -> while tmp = regex.exec str => if key? then tmp[key] else tmp









## List

# [] -> []
_.clone = -> it.slice 0

# -> [Int, Int]
_.get2D = (i, width) -> [i % width, (Math.floor i / width)]

# -> Int
_.get1D = (x, y, width) -> x + y * width

# -> []
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

_.batch = (count, list) ->
	count = Number count; if count < 1 => return []
	list = list.slice 0
	return (while list.length => list.splice 0, count)






## Obj










## List & Obj

# -> Int
_.index-by = (f, item) ->
	if _.is-type 'Object', item
		list = _.values item
		index = _.elem-index (f list), list
		return (_.keys item)[index]
	else return _.elem-index (f item), item




## Number

# -> Int
_.rand = (min, max=null) ->
	[min, max] = [0, min] if not max?
	return Math.floor (Math.random! * (max - min + 1) + min)

# -> Boolean
_.chance = (num=0.5) -> Math.random! < num

# -> Number
_.negate-if = (b, x) -> if b then -x else x









## String

# -> String
_.chr = (int) -> String.from-char-code int

# -> Int
_.ord = (str) -> str.char-code-at 0

# -> Boolean
_.is-insensitive = (a, b) -> a.to-upper-case! is b.to-upper-case!

# -> String
_.capitalize = (str) -> (str.substr 0, 1 .toUpperCase!) + str.substr 1







## Util

# -> Boolean
_.is-array = _.is-type 'Array'

# -> Int
_.bool-to-int = (b) -> if b then 1 else 0




_.flip-each = _.flip _.each
_.flip-map = _.flip _.map
_.flip-reject = _.flip _.reject
_.flip-filter = _.flip _.filter
_.flip-set-timeout = _.flip _.set-timeout

module.exports = _
