require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'
$:.push File.expand_path('../../lib', File.dirname(__FILE__))
require 'chainsaw'

set :root, File.dirname(__FILE__)
set :views, Proc.new { File.join(settings.root, 'views') }
set :public, Proc.new { File.join(settings.root, 'public') }

configure do
  $db = Chainsaw::Connection.connect('chainsaw')
  $config = YAML.load_file(File.expand_path('../../mapreduce.yml', File.dirname(__FILE__)))
  $collections = $config['conversions'].map{|cv| puts cv.inspect; cv['collection'] }
end

get '/' do
  haml :index, {}, {:collections => $collections}
end

get '/reports' do
  content_type :json
  $collections.to_json
end

get '/reports/:collection' do
  content_type :json
  $db[params[:collection]].find.sort({'_id' => 1}).to_json
end
