require 'singleton'
require 'mongo'

module Chainsaw
  class Connection
    include Singleton
    
    attr_reader :current
    
    def connect db_name=nil
      @current = Mongo::Connection.new
      @current.db(db_name) unless db_name.nil?
    end
    
    def connected?
      !current.nil?
    end
    
    def self.method_missing method, *args
      if instance.respond_to? method
        instance.__send__ method, *args
      else
        super *args
      end
    end
    
  end
end