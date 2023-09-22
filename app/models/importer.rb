require "csv"
require_relative "has_application"

class Importer
  include HasApplication

  def import_locations filename:, format: "maxmind"
    CSV.foreach filename, headers: true do |row|
      if (location = locations.find_by(reference: row["geoname_id"].to_s.strip))
        location.update name: row["country_name"].to_s.strip
      else
        locations.create reference: row["geoname_id"].to_s.strip, name: row["country_name"].to_s.strip
      end
    end
  end

  def import_blocks filename:, format: "maxmind"
    CSV.foreach filename, headers: true do |row|
      next unless (location = locations.find_by(reference: row["geoname_id"].to_s.strip))
      if (block = blocks.find_by(range: row["network"].to_s.strip))
        block.update location: location
      else
        blocks.create range: row["network"].to_s.strip, location: location
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
