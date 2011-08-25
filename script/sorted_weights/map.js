function(){
  var matches = this.sphinx_result.matches;
  for (var i = 0, l = matches.length; i < l; i++) {
    emit('weight-'+matches[i].weight, {
      count: 1,
      pos: {
        min: i,
        avg: i,
        max: i
      }
    });
  }
}