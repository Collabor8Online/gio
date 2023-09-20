class Block < ActiveRecord::Base
  belongs_to :location
  has_many :addresses, dependent: :destroy
  validates :range, presence: true, uniqueness: true

  class Entity < Grape::Entity
    expose :range, documentation: {type: "string", desc: "The CIDR range of the block"}
    expose :location, using: "Location::Entity"
  end
end
