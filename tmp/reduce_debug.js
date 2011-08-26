function reduce(k,v) {
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
      result.category_data = result.category_data.concat(o.category_data);
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
reduce('subway', [{ "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 168, "hits" : 180 } ], "total" : { "docs" : 168, "hits" : 180 } },
       { "category_data" : [ { "guid" : "CAT-88cbb033-0fc1-ff06-6532-0f357c0f5081", "docs" : 23, "hits" : 39 } ], "total" : { "docs" : 23, "hits" : 39 } },
       { "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 113, "hits" : 180 } ], "total" : { "docs" : 113, "hits" : 180 } },
       { "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 168, "hits" : 180 } ], "total" : { "docs" : 168, "hits" : 180 } },
       { "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 168, "hits" : 180 } ], "total" : { "docs" : 168, "hits" : 180 } },
       { "category_data" : [ { "guid" : "CAT-88cbb033-0fc1-ff06-6532-0f357c0f5081", "docs" : 23, "hits" : 39 } ], "total" : { "docs" : 23, "hits" : 39 } },
       { "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 168, "hits" : 180 } ], "total" : { "docs" : 168, "hits" : 180 } },
       { "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 168, "hits" : 180 } ], "total" : { "docs" : 168, "hits" : 180 } },
       { "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 168, "hits" : 180 } ], "total" : { "docs" : 168, "hits" : 180 } },
       { "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 168, "hits" : 180 } ], "total" : { "docs" : 168, "hits" : 180 } },
       { "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 168, "hits" : 180 } ], "total" : { "docs" : 168, "hits" : 180 } },
       { "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 168, "hits" : 180 } ], "total" : { "docs" : 168, "hits" : 180 } },
       { "category_data" : [ { "guid" : "CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0", "docs" : 168, "hits" : 180 } ], "total" : { "docs" : 168, "hits" : 180 } }])
