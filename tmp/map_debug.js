function map(){
  for each (var match in this.sphinx_result.matches){
    emit(this.category_guid, {weight: match.weight});
  }
}

function emit(k, v) {
  print("  k:" + k + " v:" + tojson(v));
}

var cur = db.autocat_autocat_log_entries.find({'sphinx_result.attributes.categorized_by_user': 1}).limit(1);
cur.forEach(function(x){
  map.apply(x);
});
