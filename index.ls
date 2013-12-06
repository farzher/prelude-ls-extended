_ = require 'prelude-ls'
Url = require 'url'



## Url

# from, to -> String
_.url-resolve = -> Url.resolve.apply @, arguments

# -> parsed
_.url-parse = (url) -> Url.parse url, false, true

# -> uri
_.parsed-to-uri = (parsed) -> parsed.path + (parsed.hash or '')

# url -> uri
_.url-to-uri = _.url-parse >> _.parsed-to-uri



## Regex

# -> []
_.regex-match = (regex, str) --> str.match regex or []

# -> []
_.regex-exec = (regex, str, key=null) ->
	results = []
	while tmp = regex.exec str
		results.push (if key? then tmp[key] else tmp)
	results



## List

# -> []
_.unique-by = (func, list) -->
	seen = []
	for item in list
		value = func item
		continue if value in seen
		seen.push value
		item



## Number

# -> Int
_.rand = (min, max=null) ->
	[min, max] = [0, min] if not max?
	Math.floor (Math.random! * (max - min + 1) + min)

# -> Boolean
_.chance = (num=0.5) -> Math.random! < num



## String

# -> String
_.chr = (int) -> String.from-char-code int

# -> Int
_.ord = (str) -> str.char-code-at 0

# -> Boolean
_.is-insensitive = (a, b) -> a.to-upper-case! is b.to-upper-case!



## Util

# -> Int
_.db-bool = (val) -> if val then 1 else 0

_.flip-each = _.flip _.each
_.flip-map = _.flip _.map
_.flip-reject = _.flip _.reject
_.flip-filter = _.flip _.filter
_.flip-set-timeout = _.flip _.set-timeout

module.exports = _
