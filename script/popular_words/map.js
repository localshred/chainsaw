function(){
  for (var word in this.description.split(/\s+/)) {
    emit(word, {count: 1});
  }
}
