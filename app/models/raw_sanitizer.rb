class RawSanitizer
  def initialize(raw_item)
    @raw_item = raw_item
  end

  def sanitize
    @raw_item.dup.tap do |item|
      sanitize_timestamp(item, :ends_at)
      sanitize_timestamp(item, :published_at)

      bids = item.delete :bids
      bids.each do |bid|
        sanitize_timestamp(bid, :timestamp)
      end
      item[:bids_attributes] = bids
    end
  end

  private

  def sanitize_timestamp(hash, field)
    hash[field] = Time.at(hash[field])
  end
end
