require "json"
require "bundler"
Bundler.require(:default, ENV["RACK_ENV"] ? ENV["RACK_ENV"].to_sym : :development)

OTR::ActiveRecord.configure_from_file! "./config/database.yml"
OTR::ActiveRecord.establish_connection!

