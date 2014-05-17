_ = require \../index.js

exports import
	url-resolve: ->
		it.strictEqual (_.url-resolve \/a/b/c, \../index.html), \/a/index.html
		it.done!
	url-parse: ->
		it.strictEqual (_.url-parse \http://farzher.com).host, \farzher.com
		it.done!
	parsed-to-uri: ->
		it.strictEqual (_.parsed-to-uri _.url-parse \http://farzher.com), \/
		it.done!
	url-to-uri: ->
		it.strictEqual (_.url-to-uri \http://farzher.com), \/
		it.done!
	regex-match: ->
		it.strictEqual (_.regex-match /a/g, \ababab).length, 3
		it.strictEqual (_.regex-match /does not exist/, \ababab).length, 0
		it.done!
	regex-exec: ->
		# No key
		temp = _.regex-exec /a(b)/g, \ababab
		it.strictEqual temp.length, 3
		it.strictEqual temp.2.0, \ab
		it.strictEqual temp.2.1, \b
		# With key
		temp = _.regex-exec /href="(.*?)"/g, '<a id="pants" href="something.com">lol</a>', 1
		it.strictEqual temp.0, 'something.com'
		it.done!
	shuffle: ->
		arr = [1, 2, 3, \a, \b, \c]
		shuffled = _.shuffle _.clone arr
		for v in arr
			index = _.elem-index v, shuffled
			it.ok index?, 'Every element in the original array should be in the shuffled array'
		it.done!
