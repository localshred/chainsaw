function(){
  for each (var match in this.sphinx_result.matches){
    emit(this.category_guid, {avg_weight: match.weight});
  }
}
