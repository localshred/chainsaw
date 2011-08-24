require 'yaml'

module Chainsaw
  class Process
    
    attr_accessor :conversions
    attr_reader :results
    
    def initialize raw_db, raw_col, map_reduce_file, filtered=[]
      raise 'You must provide a file to define your map reduce functions' unless File.exist?(map_reduce_file)
      @conversions = YAML.load_file(map_reduce_file)['conversions']
      @filtered = filtered
      
      # Ensure connected
      Connection.connect unless Connection.connected?
      @raw = Connection.current.db(raw_db)[raw_col]
      @results = {}
    end
    
    def run
      @conversions.each do |conv|
        next if !@filtered.nil? and !@filtered.include?(conv['collection'])
        
        puts 'conversion -> %s' % conv.inspect
        map = File.read("#{Utilio::Path.root}/#{conv['collection']}/map.js")
        reduce = File.read("#{Utilio::Path.root}/#{conv['collection']}/reduce.js")
        res = @raw.map_reduce(map, reduce, conv['restrict'] || Hash.new)
        col = Connection.current.db(conv['db'])[conv['collection']]
        if res.size > 0
          puts 'Inserting %d reduced records to %s -> %s' % [res.size, conv['db'], conv['collection']]
          res.find.to_a.each do |reduced|
            puts 'reduction -> %s' % reduced.inspect
            col.insert(reduced)
          end
        else
          puts 'Warning: no records were reduced'
        end
        puts '----'
      end
    end
    
    def stats
    end
    
  end
end
