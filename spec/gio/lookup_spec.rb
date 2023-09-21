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
    let(:uk) { subject[:locations].create! name: "United Kingdom" }
    let(:block) { subject[:blocks].create! range: "185.195.233.0/24", location: uk }

    before do
      block.touch
    end

    it "finds the country" do
      post "/api/addresses", ip_address: "185.195.233.88"

      expect(last_response.status).to eq 201

      result = JSON.parse(last_response.body)
      expect(result["name"]).to eq "United Kingdom"
    end

    it "caches the IP address" do
      post "/api/addresses", ip_address: "185.195.233.88"

      expect(subject[:addresses].find_by!(address: "185.195.233.88")).to_not be_nil
    end
  end

  context "when the IP address cannot be found" do
    let(:uk) { subject[:locations].create! name: "United Kingdom" }
    let(:block) { subject[:blocks].create! range: "185.195.233.0/24", location: uk }

    before do
      block.touch
    end

    it "returns an error code" do
      post "/api/addresses", ip_address: "122.122.122.122"

      expect(last_response.status).to eq 404
    end
  end
end
