require 'auctionet/client'

class ItemUpdater
  def initialize(client = Auctionet::Client.new)
    @client = client
  end

  def run
    Item.watched.each do |item|
      raw = client.fetch_item item.id
      sanitized = RawSanitizer.new(raw).sanitize

      bids_size = item.bids.size
      update_bids(sanitized, item)
      notify(item) if bids_size != item.bids.size
    end
  end

  private

  attr_reader :client

  def notify item
    MessageBus.publish("/bids", MultiJson.dump(item))
  end

  def update_bids(data, item)
    data[:bids_attributes].each do |attributes|
      next if item.bids.exists?(external_id: attributes[:external_id])

      bid = item.bids.build attributes
      bid.save!
    end
  end
end
