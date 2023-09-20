require_relative "../config/environment"

class Gio
  def lookup address
    self[:lookups].new(self).lookup address
  end

  def [] collection
    collections[collection.to_sym] ||= collection.to_s.classify.constantize
  end

  class << self
    def current
      @current ||= Gio.new
    end

    protected

    attr_writer :current
  end

  protected

  def collections
    @collections ||= {}
  end
end

Dir["#{__dir__}/models/*.rb"].sort.each { |file| require file }
Dir["#{__dir__}/api/*.rb"].sort.each { |file| require file }

def app
  Gio::Addresses
end
