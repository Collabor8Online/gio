require "grape"
require_relative "../gio"

class Gio
  class Addresses < Grape::API
    version "v1", using: :header, vendor: "collabor8online"
    format :json
    prefix :api

    namespace :addresses do
      get do
        {hello: "world"}
      end

      desc "Lookup the country for an IP address"
      params do
        requires :ip_address, type: String, desc: "The IP Address to lookup"
      end
      post do
        if (location = Gio.current.lookup(params[:ip_address]))
          present location
        else
          error! "Not Found", 404
        end
      end
    end
  end
end
