function reduce(k,v) {
  var result = {
    word_count: 0,
    instance_count: 0,
    words: []
  };
  
  v.forEach(function(o) { 
    result.word_count += o.word_count;
    result.instance_count += o.instance_count;
    result.words = data.words.concat(o.words);
  });
  
  return result;
}