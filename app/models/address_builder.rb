require_relative "has_application"

class AddressBuilder
  include HasApplication

  def build address
    block = find_block_matching address
    application[:addresses].create! address: address, block: block
  end

  protected

  def find_block_matching address
    address_ip = IPAddr.new address
    application[:blocks].find_each do |block|
      return block if block.include? address_ip
    end
    nil
  end
end
