function(){
  emit('all', {word_count: this.value.word_count, instance_count: this.value.instance_count});
}