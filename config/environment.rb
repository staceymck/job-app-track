ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'securerandom'
Bundler.require(:default, ENV['SINATRA_ENV'])
Dotenv.load if ENV['SINATRA_ENV'] == "development" #do I need 'if ENV....'? or just Dotenv.load

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require './app/controllers/application_controller'
require_all 'app'
