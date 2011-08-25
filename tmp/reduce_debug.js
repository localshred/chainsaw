function reduce(k,v) {
  var result = {avg_weight: 0};
  var total_weight = 0;
  v.forEach(function(o){
    total_weight += o.weight;
  });
  result.avg_weight = total_weight / v.length;
  return result;
}
reduce({k:'CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0'}, [{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 },
{ "weight" : 1 }]);
