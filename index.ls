_ = require 'prelude-ls'
Url = require 'url'

# Flip
_.flip-each = _.flip _.each
_.flip-map = _.flip _.map
_.flip-reject = _.flip _.reject
_.flip-filter = _.flip _.filter
_.flip-set-timeout = _.flip _.set-timeout

# Url
_.url-resolve = -> Url.resolve.apply @, arguments
_.url-parse = -> Url.parse it, false, true
_.parsed-to-uri = -> it.path + (it.hash or '')
_.url-to-uri = _.url-parse >> _.parsed-to-uri

# Regex
_.regex-match = (regex, str) -> str.match regex or []
_.regex-exec = (regex, str, key=null) ->
	results = []
	while tmp = regex.exec str
		results.push (if key? then tmp[key] else tmp)
	results

# List
_.unique-by = (func, list) ->
	seen = []
	for item in list
		value = func item
		continue if value in seen
		seen.push value
		item

# Util
_.db-bool = -> if it then 1 else 0
_.rand = (min, max) --> Math.floor (Math.random! * (max - min + 1) + min)
_.chance = (f=0.5) -> Math.random! < f
_.chr = (n) -> String.fromCharCode n
_.ord = (c) -> c.charCodeAt 0

module.exports = _
