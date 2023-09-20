class Address < ActiveRecord::Base
  validates :address, presence: true, uniqueness: true
  belongs_to :block
  delegate :location, to: :block

  class Entity < Grape::Entity
    expose :address, documentation: {type: "string", desc: "The IP Address"}
    expose :location, using: "Location::Entity"
  end
end
