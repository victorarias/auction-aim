class RawSanitizer
  def initialize(raw_item)
    @raw_item = raw_item
  end

  def sanitize
    @raw_item.dup.tap do |item|
      sanitize_item(item)
      bids = sanitize_bids(item)

      filter_item_fields(item)
      item[:bids_attributes] = bids
    end
  end

  private

  def filter_item_fields(item)
    item.select! { |field, _| fields_for_item.include? field}
  end

  def filter_bid_fields(bid)
    bid.select! { |field, _| fields_for_bid.include? field}
  end

  def sanitize_item(item)
    item.symbolize_keys!
    sanitize_timestamp(item, :ends_at)
    sanitize_timestamp(item, :published_at)
    item[:images].each { |image| image.symbolize_keys! }
  end

  def sanitize_bids(item)
    bids = item.delete :bids
    bids.each do |bid|
      bid.symbolize_keys!
      sanitize_timestamp(bid, :timestamp)

      filter_bid_fields(bid)

      id = bid.delete :id
      bid[:external_id] = id
    end
    bids
  end

  def sanitize_timestamp(hash, field)
    hash[field] = Time.at(hash[field])
  end

  def fields_for_item
    @fields_for_item ||= Item.column_names.map {|c| c.to_sym }
  end

  def fields_for_bid
    @fields_for_bid ||= Bid.column_names.map {|c| c.to_sym }
  end
end
