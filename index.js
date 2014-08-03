// Generated by LiveScript 1.2.0
var _;
_ = require('prelude-ls');
_.regexMatch = function(regex, str){
  return str.match(regex) || [];
};
_.regexExec = function(regex, str, key){
  var tmp, results$ = [];
  key == null && (key = null);
  while (tmp = regex.exec(str)) {
    if (key != null) {
      results$.push(tmp[key]);
    } else {
      results$.push(tmp);
    }
  }
  return results$;
};
_.clone = function(it){
  return it.slice(0);
};
_.get2D = function(i, width){
  return [i % width, Math.floor(i / width)];
};
_.get1D = function(x, y, width){
  return x + y * width;
};
_.shuffle = function(arr){
  var j, x, i;
  j = x = i = arr.length;
  while (i) {
    j = Math.floor(Math.random() * i);
    x = arr[--i];
    arr[i] = arr[j];
    arr[j] = x;
  }
  return arr;
};
_.where = function(query, list){
  return _.filter(function(it){
    var k, ref$, v;
    for (k in ref$ = query) {
      v = ref$[k];
      if (it[k] !== v) {
        return false;
      }
    }
    return true;
  }, list);
};
_.batch = function(count, list){
  count = Number(count);
  if (count < 1) {
    count = 1;
  }
  list = _.clone(list);
  return (function(){
    var results$ = [];
    while (list.length) {
      results$.push(list.splice(0, count));
    }
    return results$;
  }());
};
_.indexBy = function(f, item){
  var list, index;
  if (_.isType('Object', item)) {
    list = _.values(item);
    index = _.elemIndex(f(list), list);
    return _.keys(item)[index];
  } else {
    return _.elemIndex(f(item), item);
  }
};
_.rand = function(min, max){
  var ref$;
  max == null && (max = null);
  if (max == null) {
    ref$ = [0, min], min = ref$[0], max = ref$[1];
  }
  return Math.floor(Math.random() * (max - min + 1) + min);
};
_.chance = function(num){
  num == null && (num = 0.5);
  return Math.random() < num;
};
_.negateIf = function(b, x){
  if (b) {
    return -x;
  } else {
    return x;
  }
};
_.chr = function(int){
  return String.fromCharCode(int);
};
_.ord = function(str){
  return str.charCodeAt(0);
};
_.isInsensitive = function(a, b){
  return a.toUpperCase() === b.toUpperCase();
};
_.capitalize = function(str){
  return str.substr(0, 1).toUpperCase() + str.substr(1);
};
_.isArray = _.isType('Array');
_.boolToInt = function(b){
  if (b) {
    return 1;
  } else {
    return 0;
  }
};
_.flipEach = _.flip(_.each);
_.flipMap = _.flip(_.map);
_.flipReject = _.flip(_.reject);
_.flipFilter = _.flip(_.filter);
_.flipSetTimeout = _.flip(_.setTimeout);
module.exports = _;