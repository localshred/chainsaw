require 'rubygems'
require 'bundler/setup'
require 'thor'

$:.push File.expand_path('lib', File.dirname(__FILE__))
require 'chainsaw'

class ChainsawCLI < Thor
  include Thor::Actions
  namespace :saw
  class_option :db, :type => :string, :default => 'chainsaw', :aliases => %w(-d)
  class_option :collection, :type => :string, :default => 'raw_import', :aliases => %w(-l)
  
  desc 'import FILE', 'Import raw log data from file'
  def import file
    halt 'Invalid file specified "%s"' % file unless File.exist?(file)
    say 'Importing log file %s' % file, :yellow
    
    import = Chainsaw::Import.new(file, options.db)
    import.run
    
    say import.stats
    say 'Done', :green
  end
  
  method_option :conversions, :type => :array, :default => nil, :aliases => %w(-c)
  desc 'process MAP_REDUCE_FILE', 'Process the raw log data, specifying a YAML file as input to define the conversions'
  def process map_reduce_file
    say 'Processing raw data with map/reduce functions from %s' % map_reduce_file, :yellow
    process = Chainsaw::Process.new(options.db, options.collection, map_reduce_file, options.conversions)
    process.run
    
    say process.stats
    say 'Done', :green
  end
  
  no_tasks do    
    def halt msg, status=1
      say msg, :red
      exit status
    end
  end
  
end