// Generated by LiveScript 1.2.0
var _;
_ = require('../index.js');
exports.regexMatches = function(it){
  it.strictEqual(_.regexMatches(/a/g, 'ababab').length, 3);
  it.strictEqual(_.regexMatches(/does not exist/, 'ababab').length, 0);
  return it.done();
};
exports.regexExec = function(it){
  var temp;
  temp = _.regexExec(/a(b)/g, 'ababab');
  it.strictEqual(temp.length, 3);
  it.strictEqual(temp[2][0], 'ab');
  it.strictEqual(temp[2][1], 'b');
  temp = _.regexExec(/href="(.*?)"/g, '<a id="pants" href="something.com">lol</a>', 1);
  it.strictEqual(temp[0], 'something.com');
  return it.done();
};
exports.a = function(it){
  var tmp;
  it.deepEqual(_.a(_.a('div#header', _.a(_.a('img', 'logo.png'), _.a('h1', 'hello world'))), _.a('div#footer', 'goodbye world')), [['div#header', [['img', 'logo.png'], ['h1', 'hello world']]], ['div#footer', 'goodbye world']]);
  tmp = _.a(1);
  it.deepEqual(tmp, [1]);
  it.deepEqual(_.a(1, 2, 3), [1, 2, 3]);
  return it.done();
};
exports.clone = function(it){
  var a, b, i$, to$, i, temp;
  a = [
    1, 2, 3, 'a', 'b', 'c', {
      a: 1
    }, [1, 2]
  ];
  b = _.clone(a);
  for (i$ = 0, to$ = a.length; i$ < to$; ++i$) {
    i = i$;
    it.strictEqual(a[i], b[i], 'Every element in each array should be the same');
  }
  temp = a[0];
  b[0] = 'new';
  it.strictEqual(a[0], temp, 'Changing cloned array should not affect original');
  temp = b[0];
  a[0] = 'new';
  it.strictEqual(b[0], temp, 'Changing original array should not affect cloned');
  return it.done();
};
exports.get2D = function(it){
  var temp;
  temp = _.get2D(21, 10);
  it.strictEqual(temp[0], 1);
  it.strictEqual(temp[1], 2);
  return it.done();
};
exports.get1D = function(it){
  var temp;
  temp = _.get1D(1, 2, 10);
  it.strictEqual(temp, 21);
  return it.done();
};
exports.shuffle = function(it){
  var arr, shuffled, i$, len$, v, index;
  arr = [1, 2, 3, 'a', 'b', 'c'];
  shuffled = _.shuffle(_.clone(arr));
  it.strictEqual(arr.length, shuffled.length, 'Length of shuffled array should be the same');
  for (i$ = 0, len$ = arr.length; i$ < len$; ++i$) {
    v = arr[i$];
    index = _.elemIndex(v, shuffled);
    it.strictEqual(index != null, true, 'Every element in the original array should be in the shuffled array');
  }
  it.strictEqual(_.shuffle([]).length, 0, 'Shuffling an empty array should not cause a problem');
  return it.done();
};
exports.where = function(it){
  var list;
  list = [
    {
      a: 1,
      b: 2,
      c: 3,
      same: true
    }, {
      a: 4,
      b: 5,
      c: 6,
      same: true
    }
  ];
  it.strictEqual(_.where({
    a: 1
  }, list)[0], list[0]);
  it.strictEqual(_.where({
    c: 6,
    b: 5
  }, list)[0], list[1], 'Can find by multiple params');
  it.strictEqual(_.where({
    c: 6,
    b: 1
  }, list).length, 0, 'All must be true');
  it.strictEqual(_.where({
    same: true
  }, list).length, 2, 'Returns a list of all matches');
  it.strictEqual(_.where({
    none: [{}]
  }, list).length, 0, 'Using unknown keys returns nothing');
  return it.done();
};
exports.batch = function(it){
  var list;
  list = [
    'start', 1, 'a', {
      stuff: 'things'
    }, 2, 3, 1, 8, 3, 7, [2, 3], {}, [], 'end'
  ];
  it.strictEqual(_.batch(3, list)[1][0].stuff, 'things');
  it.strictEqual(_.batch(2, list).length, list.length / 2);
  it.strictEqual(_.batch(1, list).length, list.length);
  it.strictEqual(_.batch(list.length, list).length, 1);
  it.strictEqual(_.batch('-1', list).length, 0, 'Batching by a broken amount should return []');
  return it.done();
};
exports.compareArr = function(it){
  var temp;
  it.strictEqual(_.compareArr([1, 2, 3], [1, 2, 3]), true);
  it.strictEqual(_.compareArr([1, {}, 3], [1, {}, 3]), false, 'Different objects should be different');
  it.strictEqual(_.compareArr([1], [1, 1]), false, 'Different size arrays should be different');
  temp = {};
  it.strictEqual(_.compareArr([22, temp], [22, temp]), true, 'Same objects should be the same');
  return it.done();
};
exports['in'] = function(it){
  it.strictEqual(_['in'](1, [2, 2, 1]), true);
  return it.done();
};
exports.variance = function(it){
  it.strictEqual(_.variance([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]), 10);
  return it.done();
};
exports.stdDeviation = function(it){
  it.strictEqual(+_.stdDeviation([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]).toFixed(2), 3.16);
  return it.done();
};
exports.outsideStdDeviation = function(it){
  it.deepEqual(_.outsideStdDeviation([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]), [1, 2, 10, 11], true);
  return it.done();
};
exports.outsideStdDeviationBy = function(it){
  var stuff, res$, i$, i, outside;
  res$ = [];
  for (i$ = 1; i$ <= 11; ++i$) {
    i = i$;
    res$.push({
      score: i,
      name: "Item: " + i
    });
  }
  stuff = res$;
  outside = [stuff[0], stuff[1], stuff[9], stuff[10]];
  it.deepEqual(_.outsideStdDeviationBy(function(it){
    return it.score;
  }, stuff), outside, true);
  return it.done();
};
exports.chance = function(it){
  it.strictEqual(_.chance(0), false);
  it.strictEqual(_.chance(1), true);
  return it.done();
};
exports.negateIf = function(it){
  it.strictEqual(_.negateIf(true, 5), -5);
  it.strictEqual(_.negateIf(false, 5), 5);
  return it.done();
};
exports.toggleIf = function(it){
  it.strictEqual(_.toggleIf(true, true), false);
  it.strictEqual(_.toggleIf(false, false), false);
  it.strictEqual(_.toggleIf(5, 5), false);
  it.strictEqual(_.toggleIf(true, 0), true);
  return it.done();
};
exports.toBit = function(it){
  it.strictEqual(_.toBit(true), 1);
  it.strictEqual(_.toBit(false), 0);
  it.strictEqual(_.toBit(5), 1);
  it.strictEqual(_.toBit(0), 0);
  return it.done();
};
exports.rand = function(it){
  var ref$;
  it.strictEqual((ref$ = _.rand(0, 1)) === 1 || ref$ === 0, true);
  it.strictEqual((ref$ = _.rand(1, 2)) === 1 || ref$ === 2, true);
  return it.done();
};
exports.randFloat = function(it){
  var tmp;
  tmp = _.randFloat(0, 1);
  it.strictEqual(tmp >= 0 && tmp <= 1, true);
  tmp = _.randFloat(1, 2);
  it.strictEqual(tmp >= 1 && tmp <= 2, true);
  return it.done();
};
exports.randWeight = function(it){
  var stuff;
  stuff = [['heavy', 1000000000], ['light', 1]];
  it.strictEqual(_.randWeight(stuff), 'heavy');
  it.strictEqual(_.randWeight(stuff, {
    invert: true
  }), 'light');
  return it.done();
};
exports.mapNumber = function(it){
  it.strictEqual(_.mapNumber(0.5, 0, 1, 0, 100), 50);
  it.strictEqual(_.mapNumber(0.5, 0, 1, 0, 100, {
    exponent: 2
  }), 25);
  it.strictEqual(_.mapNumber(-0.5, 0, 1, 0, 100, {
    exponent: 2
  }), -25);
  it.strictEqual(_.mapNumber(-0.5, 0, 1, 0, 1, {
    exponent: 2.1
  }), -Math.pow(0.5, 2.1));
  it.strictEqual(_.mapNumber(0, 0, 1, 100, 0), 100);
  return it.done();
};
exports.isNumeric = function(it){
  it.strictEqual(_.isNumeric(1), true);
  it.strictEqual(_.isNumeric('50.34'), true);
  it.strictEqual(_.isNumeric('50.34b'), false);
  it.strictEqual(_.isNumeric('0x50.34'), false);
  it.strictEqual(_.isNumeric('0x50.34'), false);
  it.strictEqual(_.isNumeric({}), false);
  it.strictEqual(_.isNumeric('-23.23'), true);
  it.strictEqual(_.isNumeric('-23.23.23'), false);
  return it.done();
};
exports['import'] = function(it){
  var a, b;
  a = {
    a: 1
  };
  b = {
    b: 2
  };
  _['import'](b, a, {
    a: 2
  });
  it.strictEqual(b.a, 2);
  return it.done();
};
exports.newObj = function(it){
  var a, b, c;
  a = {
    a: 1
  };
  b = {
    b: 2
  };
  c = _.newObj(a, {
    a: 2
  });
  it.strictEqual(c.a, 2);
  it.strictEqual(a.a, 1);
  return it.done();
};
exports.indexBy = function(it){
  var list, obj;
  list = [1, 9, 3];
  it.strictEqual(_.indexBy(_.maximum, list), 1, 'Index of highest number is 1');
  obj = {
    butts: 1,
    cats: 9,
    rocks: 3
  };
  it.strictEqual(_.indexBy(_.minimum, obj), 'butts', 'Index of lowest number is butts');
  return it.done();
};
exports.isStr = function(it){
  it.strictEqual(_.isStr('1'), true);
  return it.done();
};
exports.chr = function(it){
  it.strictEqual(_.chr(97), 'a');
  return it.done();
};
exports.ord = function(it){
  it.strictEqual(_.ord('a'), 97);
  return it.done();
};
exports.isInsensitive = function(it){
  it.strictEqual(_.isInsensitive('sOmEtHiNg', 'something'), true);
  it.strictEqual(_.isInsensitive('sOmEtHiNg else', 'something'), false);
  it.strictEqual(_.isInsensitive(['not a string'], 'something'), false);
  return it.done();
};
exports.inInsensitive = function(it){
  it.strictEqual(_.inInsensitive('lEeT', ['fish', 'CATS', 'LEET']), true);
  it.strictEqual(_.inInsensitive('lEeTs', ['fish', 'CATS', 'LEET']), false);
  it.strictEqual(_.inInsensitive(['not a string'], ['fish', 'CATS', 'LEET']), false);
  return it.done();
};
exports.capitalize = function(it){
  it.strictEqual(_.capitalize('cats'), 'Cats');
  return it.done();
};
exports.isArr = function(it){
  it.strictEqual(_.isArr([]), true);
  it.strictEqual(_.isArr({}), false);
  return it.done();
};
exports.isObj = function(it){
  it.strictEqual(_.isObj([]), false);
  it.strictEqual(_.isObj({}), true);
  return it.done();
};
exports.isBool = function(it){
  it.strictEqual(_.isBool(false), true);
  it.strictEqual(_.isBool(1), false);
  return it.done();
};
exports.isNum = function(it){
  it.strictEqual(_.isNum(0), true);
  it.strictEqual(_.isNum('1'), false);
  return it.done();
};
exports.toJson = function(it){
  var circular;
  circular = {};
  circular.circular = circular;
  it.strictEqual(_.toJson({
    a: 1
  }), '{"a":1}');
  it.strictEqual(_.toJson(circular), undefined);
  it.strictEqual(_.toJson('{NOT} JSON'), JSON.stringify('{NOT} JSON'));
  return it.done();
};
exports.jsonParse = function(it){
  it.strictEqual(_.jsonParse('{"a":1}').a, 1);
  it.strictEqual(_.jsonParse('NOT JSON'), undefined);
  return it.done();
};