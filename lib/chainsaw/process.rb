require 'yaml'

module Chainsaw
  class Process
    
    attr_accessor :conversions
    attr_reader :results
    
    def initialize source_db, source_col, scripts=[]
      @scripts = scripts
      
      # Ensure connected
      Connection.connect unless Connection.connected?
      @source = Connection.current.db(source_db)[source_col]
    end
    
    def run
      script_glob = @scripts.empty? ? '*' : "{#{@scripts.join(',')}}"
      Dir[Utilio::Path.root('script', script_glob)].each do |script|
        next if !@scripts.nil? and !@scripts.include?(script)
        
        puts 'running script -> %s' % script
        
        map_path = Utilio::Path.root('script', script, 'map.js')
        query_path = Utilio::Path.root('script', script, 'query.rb')
        if File.exist?(map_path)
          puts 'script is map/reduce report'
          map = File.read(map_path)
          reduce = File.read(Utilio::Path.root('script', script, 'reduce.js'))
          res = @source.map_reduce(map, reduce, {out: script})
        elsif File.exist?(query_path)
          puts 'script is query report'
          load query_path
        end
        
        puts '----'
      end
    end
    
  end
end
