module Chainsaw
  autoload :Connection,   'chainsaw/connection'
  autoload :Import,       'chainsaw/import'
  autoload :Process,      'chainsaw/process'
  autoload :Web,          'chainsaw/web'
  Utilio::Path.root = File.expand_path('../', File.dirname(__FILE__))
end
