def run_query(source)
  puts 'Not recatigorized count: %s' % source.find({:recategorized_to => nil}).count
end
