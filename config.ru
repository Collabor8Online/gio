require_relative "app/api"

use OTR::ActiveRecord::ConnectionManagement
use OTR::ActiveRecord::QueryCache
use Rack::CommonLogger

run app
