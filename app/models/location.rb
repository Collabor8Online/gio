class Location < ActiveRecord::Base
  has_many :blocks, dependent: :destroy
  has_many :addresses, through: :blocks
  validates :name, presence: true, uniqueness: true

  class Entity < Grape::Entity
    expose :name, documentation: {type: "string", desc: "Name of the location"}
  end
end
