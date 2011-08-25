function(){
  for (var word in this.sphinx_result.words) {
    emit(word, this.sphinx_result.words[word]);
  }
}
