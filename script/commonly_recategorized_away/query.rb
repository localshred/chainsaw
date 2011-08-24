def run_query(source)
  reduce = File.read(Utilio::Path.root('script', 'commonly_categorized', 'reduce.js'))
  query = {:key => 'category_guid',
           :initial => {:count => 0},
           :cond => {:recategorized_to => {'$ne' => nil}},
           :reduce => reduce
  }
  puts "query: #{query}"
  results = source.group(query)
  puts results.sort {|one,two| one['count'] <=> two['count']}.last
end
