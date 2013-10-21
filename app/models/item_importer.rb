require 'auctionet/client'

class ItemImporter
  def initialize(client = Auctionet::Client.new)
    @client = client
  end

  def run
    client.fetch.each do |raw|
      sanitized = sanitize(raw)

      next if Item.exists? sanitized[:id]

      Item.new(sanitized).tap do |item|
        item.watched = false
        item.save!
      end
    end
  end

  private

  attr_reader :client

  def sanitize raw
    RawSanitizer.new(raw).sanitize
  end
end
