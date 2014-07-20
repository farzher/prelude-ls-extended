_ = require \../index.js

exports import
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
	clone: ->
		a = [1, 2, 3, \a, \b, \c, {a: 1}, [1, 2]]
		b = _.clone a
		for i til a.length => it.strictEqual a[i], b[i], 'Every element in each array should be the same'
		temp = a.0; b.0 = \x; it.strictEqual a.0, temp, 'Changing cloned array should not affect original'
		temp = b.0; a.0 = \z; it.strictEqual b.0, temp, 'Changing original array should not affect cloned'
		it.done!
	shuffle: ->
		arr = [1, 2, 3, \a, \b, \c]
		shuffled = _.shuffle _.clone arr
		it.strictEqual arr.length, shuffled.length, 'Length of shuffled array should be the same'
		for v in arr
			index = _.elem-index v, shuffled
			it.ok index?, 'Every element in the original array should be in the shuffled array'
		it.strictEqual (_.shuffle []).length, 0, 'Shuffling an empty array should not cause a problem'
		it.done!
	index-by: ->
		list = [1, 9, 3]
		it.strictEqual (_.index-by _.maximum, list), 1, 'Index of highest number is 1'
		obj = {butts: 1, cats: 9, rocks: 3}
		it.strictEqual (_.index-by _.minimum, obj), 'butts', 'Index of lowest number is butts'
		it.done!
	where: ->
		list =
			{a: 1, b: 2, c: 3, same: true}
			{a: 4, b: 5, c: 6, same: true}
		it.strictEqual (_.where {a: 1}, list).0, list.0
		it.strictEqual (_.where {c: 6, b: 5}, list).0, list.1, 'Can find by multiple params'
		it.strictEqual (_.where {c: 6, b: 1}, list).length, 0, 'All must be true'
		it.strictEqual (_.where {same: true}, list).length, 2, 'Returns a list of all matches'
		it.strictEqual (_.where {none: [{}]}, list).length, 0, 'Using unknown keys returns nothing'
		it.done!
