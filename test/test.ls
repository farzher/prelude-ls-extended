_ = require \../index.js

exports import
	regex-matches: ->
		it.strictEqual (_.regex-matches /a/g, \ababab).length, 3
		it.strictEqual (_.regex-matches /does not exist/, \ababab).length, 0
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
	a: ->
		it.deepEqual do
			_.a do
				_.a 'div#header' _.a do
					_.a 'img' 'logo.png'
					_.a 'h1' 'hello world'
				_.a 'div#footer' 'goodbye world'

			[
				[
					'div#header'
					[
						['img', 'logo.png']
						['h1', 'hello world']
					]
				]
				['div#footer', 'goodbye world']
			]

		tmp = _.a do
			1
		it.deepEqual tmp, [1]

		it.deepEqual (_.a 1 2 3), [1 2 3]
		it.done!
	clone: ->
		a = [1, 2, 3, \a, \b, \c, {a: 1}, [1, 2]]
		b = _.clone a
		for i til a.length => it.strictEqual a[i], b[i], 'Every element in each array should be the same'
		temp = a.0; b.0 = \new; it.strictEqual a.0, temp, 'Changing cloned array should not affect original'
		temp = b.0; a.0 = \new; it.strictEqual b.0, temp, 'Changing original array should not affect cloned'
		it.done!
	get2D: ->
		temp = _.get2D 21, 10
		it.strictEqual temp.0, 1
		it.strictEqual temp.1, 2
		it.done!
	get1D: ->
		temp = _.get1D 1, 2, 10
		it.strictEqual temp, 21
		it.done!
	shuffle: ->
		arr = [1, 2, 3, \a, \b, \c]
		shuffled = _.shuffle _.clone arr
		it.strictEqual arr.length, shuffled.length, 'Length of shuffled array should be the same'
		for v in arr
			index = _.elem-index v, shuffled
			it.strictEqual index?, true, 'Every element in the original array should be in the shuffled array'
		it.strictEqual (_.shuffle []).length, 0, 'Shuffling an empty array should not cause a problem'
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
	batch: ->
		list = ['start', 1, 'a', {stuff: 'things'}, 2, 3, 1, 8, 3, 7, [2, 3], {}, [], 'end']
		it.strictEqual (_.batch 3, list).1.0.stuff, 'things'
		it.strictEqual (_.batch 2, list).length, list.length / 2
		it.strictEqual (_.batch 1, list).length, list.length
		it.strictEqual (_.batch list.length, list).length, 1
		it.strictEqual (_.batch '-1', list).length, 0, 'Batching by a broken amount should return []'
		it.done!
	variance: ->
		it.strictEqual (_.variance [1 to 11]), 10
		it.done!
	std-deviation: ->
		it.strictEqual (+_.std-deviation [1 to 11] .to-fixed 2), 3.16
		it.done!
	outside-std-deviation: ->
		it.deepEqual (_.outside-std-deviation [1 to 11]), [1 2 10 11], true
		it.done!
	outside-std-deviation-by: ->
		stuff = for i from 1 to 11 => {score: i, name: "Item: #i"}
		outside = [stuff.0, stuff.1, stuff.9, stuff.10]
		it.deepEqual (_.outside-std-deviation-by (.score), stuff), outside, true
		it.done!
	chance: ->
		it.strictEqual (_.chance 0), false
		it.strictEqual (_.chance 1), true
		it.done!
	negate-if: ->
		it.strictEqual (_.negate-if true, 5), -5
		it.strictEqual (_.negate-if false, 5), 5
		it.done!
	flip-if: ->
		it.strictEqual (_.flip-if true, true), false
		it.strictEqual (_.flip-if false, false), false
		it.strictEqual (_.flip-if 5, 5), false
		it.strictEqual (_.flip-if true, 0), true
		it.done!
	rand: ->
		it.strictEqual ((_.rand 0, 1) in [1, 0]), true
		it.strictEqual ((_.rand 1, 2) in [1, 2]), true
		it.done!
	rand-float: ->
		tmp = _.rand-float 0, 1
		it.strictEqual (tmp>=0 and tmp<=1), true
		tmp = _.rand-float 1, 2
		it.strictEqual (tmp>=1 and tmp<=2), true
		it.done!
	rand-weight: ->
		stuff = [['heavy', 1000000000] ['light', 1]]
		it.strictEqual (_.rand-weight stuff), 'heavy'
		it.strictEqual (_.rand-weight stuff, {+invert}), 'light'
		it.done!
	map-number: ->
		it.strictEqual (_.map-number 0.5, 0, 1, 0, 100), 50
		it.strictEqual (_.map-number 0.5, 0, 1, 0, 100, {exponent:2}), 25
		it.strictEqual (_.map-number 0, 0, 1, 100, 0), 100
		it.done!
	index-by: ->
		list = [1, 9, 3]
		it.strictEqual (_.index-by _.maximum, list), 1, 'Index of highest number is 1'
		obj = {butts: 1, cats: 9, rocks: 3}
		it.strictEqual (_.index-by _.minimum, obj), 'butts', 'Index of lowest number is butts'
		it.done!
	compare-array: ->
		it.strictEqual (_.compare-array [1 2 3], [1 2 3]), true
		it.strictEqual (_.compare-array [1 {} 3], [1 {} 3]), false, 'Different objects should be different'
		it.strictEqual (_.compare-array [1], [1 1]), false, 'Different size arrays should be different'
		temp = {}
		it.strictEqual (_.compare-array [22, temp], [22, temp]), true, 'Same objects should be the same'
		it.done!
	chr: ->
		it.strictEqual (_.chr 97), 'a'
		it.done!
	ord: ->
		it.strictEqual (_.ord 'a'), 97
		it.done!
	is-insensitive: ->
		it.strictEqual ('sOmEtHiNg' `_.is-insensitive` 'something'), true
		it.strictEqual ('sOmEtHiNg else' `_.is-insensitive` 'something'), false
		it.strictEqual (['not a string'] `_.is-insensitive` 'something'), false
		it.done!
	in-insensitive: ->
		it.strictEqual ('lEeT' `_.in-insensitive` ['fish', 'CATS', 'LEET']), true
		it.strictEqual ('lEeTs' `_.in-insensitive` ['fish', 'CATS', 'LEET']), false
		it.strictEqual (['not a string'] `_.in-insensitive` ['fish', 'CATS', 'LEET']), false
		it.done!
	capitalize: ->
		it.strictEqual (_.capitalize 'cats'), 'Cats'
		it.done!
	is-array: ->
		it.strictEqual (_.is-array []), true
		it.strictEqual (_.is-array {}), false
		it.done!
	to-bit: ->
		it.strictEqual (_.to-bit true), 1
		it.strictEqual (_.to-bit false), 0
		it.strictEqual (_.to-bit 5), 1
		it.strictEqual (_.to-bit 0), 0
		it.done!

