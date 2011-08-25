function (k,v) {
  var result = {docs: 0, hits: 0};
  v.forEach(function(o){
    result.docs += o.docs;
    result.hits += o.hits;
  });
  return result;
}