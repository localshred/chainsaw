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
      puts script_glob
      puts Dir[Utilio::Path.root('script', script_glob)].join("\n")
      
      Dir[Utilio::Path.root('script', script_glob)].each do |script_path|
        script = File.basename(script_path)
        
        puts 'checking script -> %s' % script
        next if !@scripts.nil? and !@scripts.include?(script)
        puts 'running script -> %s' % script
        
        map_path = Utilio::Path.root('script', script, 'map.js')
        query_path = Utilio::Path.root('script', script, 'query.rb')
        
        if File.exist?(map_path)
          puts map_path
          puts query_path
          puts 'script is map/reduce report'
          
          options = {out: script}
          options_path = Utilio::Path.root('script', script, 'options.yml')
          options.merge!(YAML.load_file(options_path) || Hash.new) if File.exist?(options_path)
          puts options.inspect
          
          map = File.read(map_path)
          puts map
          reduce = File.read(Utilio::Path.root('script', script, 'reduce.js'))
          puts reduce

          finalize = File.read(Utilio::Path.root('script', script, 'finalize.js'))
          puts finalize
          options.merge!({finalize: finalize}) if(!finalize.empty?)

          puts 'running map/reduce'
          @result = @source.map_reduce(map, reduce, options)
        elsif File.exist?(query_path)
          puts 'script is query report'
          
          load query_path
          run_query(@source)
        else
          puts 'nothing happened!'
        end
        
        puts '----'
      end
    end
    
  end
end
