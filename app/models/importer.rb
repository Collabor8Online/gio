require "csv"
require_relative "has_application"

class Importer
  include HasApplication

  def import_locations filename:, format: "maxmind"
    CSV.foreach filename, headers: true do |row|
      if (location = locations.find_by(reference: row["geoname_id"].strip))
        location.update name: row["country_name"].strip
      else
        locations.create reference: row["geoname_id"].strip, name: row["country_name"].strip
      end
    end
  end

  def import_blocks filename:, format: "maxmind"
    CSV.foreach filename, headers: true do |row|
      next unless (location = locations.find_by(reference: row["geoname_id"].strip))
      if (block = blocks.find_by(range: row["network"].to_s))
        block.update location: location
      else
        blocks.create range: row["network"].strip, location: location
      end
    end
  end

  def locations
    application[:locations]
  end

  def blocks
    application[:blocks]
  end
end
