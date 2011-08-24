function (k,v) {
  var result = {count: 0};
  v.forEach(function(o){ result.count += o.count; });
  return result;
}