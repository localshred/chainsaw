function(k,v){
  var sum = 0;
  v.forEach(function(f) { 
    sum += f.count;
  }); 
  return {count: sum};
}
