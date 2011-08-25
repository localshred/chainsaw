function(k,v) {
  var result = {total_weight: 0, count: 0};
  var total_weight = 0;
  v.forEach(function(o){
    result.total_weight += o.total_weight;
    result.count += o.count;
  });
  return result;
}
