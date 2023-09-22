require_relative "has_application"

class Lookup
  include HasApplication

  def lookup(address)
    found = application[:addresses].find_by(address: address) || application[:address_builder].new(application).build(address)

    found&.location
  end
end
