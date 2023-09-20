require_relative "../spec_helper"
require_relative "../../app/gio"

describe "finding the country from an IP address" do
  include Rack::Test::Methods

  subject { Gio.current }

  context "when the IP address is cached" do
    let(:uk) { subject[:locations].create! name: "United Kingdom" }
    let(:block) { subject[:blocks].create! range: "185.195.233.0/24", location: uk }
    let(:existing) { subject[:addresses].create! address: "185.195.233.88", block: block }

    before do
      existing.touch
    end

    it "says hello" do
      get "/api/addresses"
      expect(last_response.status).to eq 200
      result = JSON.parse(last_response.body)
      expect(result["hello"]).to eq "world"
    end

    it "finds the country" do
      post "/api/addresses", ip_address: "185.195.233.88"

      expect(last_response.status).to eq 201

      result = JSON.parse(last_response.body)
      expect(result["name"]).to eq "United Kingdom"
    end
  end

  context "when the IP address is not cached" do
  end
end
