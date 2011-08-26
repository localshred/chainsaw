function(){
  var result = {category_data: [{guid: '', docs: 0, hits: 0}], total: {docs: 0, hits: 0}};
  result.category_data[0].guid = this.category_guid;
  for (var word in this.sphinx_result.words) {
    result.total.docs = this.sphinx_result.words[word].docs;
    result.total.hits = this.sphinx_result.words[word].hits;
    result.category_data[0].docs = this.sphinx_result.words[word].docs;
    result.category_data[0].hits = this.sphinx_result.words[word].hits;
    emit(word, result);
  }
}
