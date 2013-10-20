class Item < ActiveRecord::Base
  has_many :bids
  accepts_nested_attributes_for :bids

  validates_presence_of :title, :ends_at, :published_at


  class << self
    def import(raw)
      return if Item.where(id: raw[:id]).any?

      sanitized = sanitize(raw)
      Item.new(sanitized).tap do |item|
        item.save!
      end
    end

    def sanitize raw
      RawSanitizer.new(raw).sanitize
    end
  end
end
