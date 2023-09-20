require_relative "../config/environment"

module API
end

Dir["#{__dir__}/models/*.rb"].sort.each { |file| require file }
Dir["#{__dir__}/gio/*.rb"].sort.each { |file| require file }

def app
  Gio::Lookup
end
