class ItemUpdater
  def initialize(client = Auctionet::Client.new)
    @client = client
  end

  def run
    Item.watched.each do |item|
      raw = client.fetch_item item.id
      sanitized = RawSanitizer.new(raw).sanitize

      sanitized[:bids_attributes].each do |attributes|
        next if item.bids.exists?(external_id: attributes[:external_id])

        bid = item.bids.build attributes
        bid.save!

        notify(item)
      end
    end
  end

  private

  attr_reader :client

  def notify item
    MessageBus.publish("/bids", item)
  end
end
