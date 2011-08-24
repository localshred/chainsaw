function(){
  var words = this.description.split(/\s+/);
  for (var i=0, l=words.length; i < l; i++) {
    emit(words[i].toLowerCase(), {count: 1});
  }
}
