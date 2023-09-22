require_relative "has_application"

class AddressBuilder
  include HasApplication

  def build(address)
    block = find_block_matching address
    block.nil? ? nil : application[:addresses].create!(address: address, block: block)
  end

  protected

  def find_block_matching(address)
    address_ip = IPAddr.new address
    pieces = address.split(".")
    # Try to limit how many blocks we have to search through
    three_pieces = [pieces[0], pieces[1], pieces[2]].join(".")
    two_pieces = [pieces[0], pieces[1]].join(".")
    one_piece = pieces[0]
    [three_pieces, two_pieces, one_piece].each do |range|
      puts range 
      application[:blocks].where("range like ?", "#{range}%").find_each do |block|
        return block if block.include? address_ip
      end
    end
    application[:blocks].find_each do |block|
      return block if block.include? address_ip
    end
    nil
  end
end
