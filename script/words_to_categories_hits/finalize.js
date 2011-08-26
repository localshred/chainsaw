function (k,v){
  var result = {category_data: [], total: {docs: 0, hits: 0}};
  Array.prototype.findIndexByCol = function(value,cIdx){
    for (var i=0; i < this.length; i++) {
      // use === to check for Matches. ie., identical (===), ;
      if (this[i][cIdx] == value) {
        //alert(this[i][cIdx]+"===="+value);
        return i;
      }
    }
    return null;
  };

  v.forEach(function(o){
    if(result.category_data.findIndexByCol(o.category_data[0].guid, 'guid') == null){
      result.category_data = o.category_data;
    }else{
      index = result.category_data.findIndexByCol(o.category_data[0].guid, 'guid');
      result.category_data[index].docs += o.category_data[0].docs;
      result.category_data[index].hits += o.category_data[0].hits;
    }
    result.total.docs += o.total.docs;
    result.total.hits += o.total.hits;
  });
  return result;
}
