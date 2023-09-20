ENV["RACK_ENV"] ||= "test"

require "rack/test"
require "sqlite3"
require "database_cleaner"
require_relative "../config/environment"
require_relative "factories"

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.clean
  end
end
