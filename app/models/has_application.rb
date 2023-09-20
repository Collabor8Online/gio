require_relative "../gio"
module HasApplication
  def initialize application = Gio.current
    @application = application
  end

  def application
    @application
  end
end
