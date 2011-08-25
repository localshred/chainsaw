function(k,v) {
  var result = {avg_weight: 0};
  var total_weight = 0;
  v.forEach(function(o){
    total_weight += o.weight;
  });
  result.avg_weight = total_weight / v.length;
  return result;
}
