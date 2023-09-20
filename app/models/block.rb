class Block < ActiveRecord::Base
  belongs_to :location
  has_many :addresses, dependent: :destroy
  validates :range, presence: true, uniqueness: true

  def include? address
    address = IPAddr.new(address) unless address.is_a? IPAddr
    to_range.include? address
  end

  class Entity < Grape::Entity
    expose :range, documentation: {type: "string", desc: "The CIDR range of the block"}
    expose :location, using: "Location::Entity"
  end

  protected

  def to_range
    @to_range ||= to_ip.to_range
  end

  def to_ip
    @to_ip ||= IPAddr.new range
  end
end
