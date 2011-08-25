def run_query(source)
  source.find({'sphinx_result.error' => {'$ne' => nil}}).each do |record|
    puts '%s %s' % [record["_id"].generation_time, record['sphinx_result']['error']]
  end
end