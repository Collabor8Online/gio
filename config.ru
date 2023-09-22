require_relative "app/gio"

use OTR::ActiveRecord::ConnectionManagement
use OTR::ActiveRecord::QueryCache
use Rack::CommonLogger

run app
