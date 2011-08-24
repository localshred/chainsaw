function(k,v) {
  var result = {
    word_count: 0,
    instance_count: 0
  };
  
  v.forEach(function(o){
    result.word_count += o.word_count;
    result.instance_count += o.instance_count;
  });
  
  return result;
}