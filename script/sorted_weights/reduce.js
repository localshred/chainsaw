function (k,v) {
  var result = {
    count: 0,
    pos: {
      min: 0,
      avg: 0,
      max: 0
    }
  };
  
  var totalPos = 0;
  
  v.forEach(function(o){
    result.count += o.count;
    totalPos += o.pos.max;
    if (o.pos.min < result.pos.min)
      result.pos.min = o.pos.min;
    if (o.pos.max > result.pos.max)
      result.pos.max = o.pos.max;
  });
  
  result.pos.avg = totalPos / v.length;
  
  return result;
}