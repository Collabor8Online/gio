require_relative "../spec_helper"
require_relative "../../app/gio"

describe "importing MaxMind data files" do
  subject { Importer.new(gio) }

  let(:gio) { Gio.current }
  let(:locations) { gio[:locations] }
  let(:blocks) { gio[:blocks] }

  let(:folder) { File.join(__dir__, "..", "files") }
  let(:locations_filename) { File.join(folder, "locations.csv") }
  let(:blocks_filename) { File.join(folder, "blocks.csv") }

  context "importing a locations file" do
    it "imports all locations" do
      subject.import_locations filename: locations_filename

      expect(locations.count).to eq 3
      expect(locations.find_by(reference: "2635167")&.name).to eq "United Kingdom"
      expect(locations.find_by(reference: "1814991")&.name).to eq "China"
      expect(locations.find_by(reference: "2077456")&.name).to eq "Australia"
    end
  end

  context "importing a blocks file" do
    let(:australia) { locations.find_by(reference: "2077456") }
    let(:china) { locations.find_by(reference: "1814991") }
    let(:united_kingdom) { locations.find_by(reference: "2635167") }

    before do
      subject.import_locations filename: locations_filename
    end

    it "imports blocks when a location exists" do
      subject.import_blocks filename: blocks_filename

      expect(blocks.count).to eq 7

      ["1.0.0.0/24", "1.0.4.0/22"].each do |range|
        expect(blocks.find_by(range: range).location).to eq australia
      end
      ["1.0.1.0/24", "1.0.2.0/23"].each do |range|
        expect(blocks.find_by(range: range).location).to eq china
      end
      ["2.16.34.0/24", "2.16.37.0/24", "145.239.221.112/28"].each do |range|
        expect(blocks.find_by(range: range).location).to eq united_kingdom
      end
    end

    it "ignores blocks if it cannot find the location" do
      china.destroy 

      subject.import_blocks filename: blocks_filename

      expect(blocks.count).to eq 5

      ["1.0.0.0/24", "1.0.4.0/22"].each do |range|
        expect(blocks.find_by(range: range).location).to eq australia
      end
      ["1.0.1.0/24", "1.0.2.0/23"].each do |range|
        expect(blocks.find_by(range: range)).to be_nil
      end
      ["2.16.34.0/24", "2.16.37.0/24", "145.239.221.112/28"].each do |range|
        expect(blocks.find_by(range: range).location).to eq united_kingdom
      end
    end
  end
end
