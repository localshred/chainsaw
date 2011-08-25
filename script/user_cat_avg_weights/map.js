function(){
  for each (var match in this.sphinx_result.matches){
    emit(this.category_guid, {total_weight: match.weight, count: 1});
  }
}
