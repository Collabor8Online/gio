require_relative "spec_helper"

decribe "finding the country from an IP address" do 
  include Rack::Test::Methods

  subject { GioLookup.new }

  context "when the IP address is cached" do
    let(:uk) { subject[:locations].create name: "United Kingdom" }
    let(:existing) = { subject[:addresses].create value: "185.195.233.88", location: uk }

    before do 
      existing.touch 
    end

    it "finds the country" do
      get "/gio/lookup/185.193.233.88"

      expect(last_response.status).to eq 200

      result = JSON.parse(last_response.body)
      expect(result["country"]).to eq "United Kingdom"
    end
  end

  context "when the IP address is not cached" do 

  end
end