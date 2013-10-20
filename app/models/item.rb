class Item < ActiveRecord::Base
  has_many :bids
  accepts_nested_attributes_for :bids

  validates_presence_of :title, :ends_at, :published_at


  class << self
    def import(raw)
      return if Item.where(id: raw[:id]).any?
      raw = sanitize_raw_data raw

      Item.new(raw).tap do |item|
        item.save!
      end
    end

    private

    def sanitize_timestamp(hash, field)
      hash[field] = Time.at(hash[field])
    end

    def sanitize_raw_data(raw)
      sanitize_timestamp(raw, :ends_at)
      sanitize_timestamp(raw, :published_at)

      bids = raw.delete :bids
      bids.each do |bid|
        sanitize_timestamp(bid, :timestamp)
      end
      raw[:bids_attributes] = bids

      raw
    end
  end
end
