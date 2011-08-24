def run_query(source)
  puts 'Recatigorizations: %s' % source.find({:recategorized_to => {'$ne' => nil}}).count
end
