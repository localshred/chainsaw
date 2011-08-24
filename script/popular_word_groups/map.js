function () {
  var groupLen = 1000;
  var value = parseInt(this.value.count);
  var groupStart = value - (value % groupLen);
  var groupEnd = groupStart + (groupLen - 1);
  var key = groupStart+"-"+groupEnd;
  
  emit(key, {
    word_count: 1,
    instance_count: value,
    words: [this._id]
  });
}