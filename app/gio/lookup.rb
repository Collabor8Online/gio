require "grape"
require_relative "application"

module Gio
  class Lookup < Grape::API
    version "v1", using: :header, vendor: "collabor8online"
    format :json
    prefix :gio

    resources :lookup do
      desc "Lookup the country for an IP address" do
        success [Location::Entity]
      end
      get do
        status 404 
      end
    end
  end
end

