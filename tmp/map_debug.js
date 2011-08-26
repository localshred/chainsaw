function map(){
  var result = {category_guid: '', docs: 0, hits: 0}};
  result.category_guid = this.category_guid;
  for (var word in this.sphinx_result.words) {
    result.docs = this.sphinx_result.words[word].docs;
    result.hits = this.sphinx_result.words[word].hits;
    emit(word, result);
  }
}

function emit(k, v) {
  print("  k:" + k + " v:" + tojson(v));
}

var cur = db.autocat_autocat_log_entries.find({category_guid: 'CAT-b1de2a04-db08-b6ed-f6fe-ca2f5b11c2d0', 'sphinx_result': {'$ne': null}}).limit(100);
cur.forEach(function(x){
  map.apply(x);
});
