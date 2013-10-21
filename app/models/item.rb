require 'auctionet/client'

class Item < ActiveRecord::Base
  has_many :bids
  accepts_nested_attributes_for :bids

  validates_presence_of :title, :ends_at, :published_at

  scope :unwatched, ->{ where(watched: false) }
  scope :watched, ->{ where(watched: true) }

  class << self
    def import(client = Auctionet::Client.new)
      client.fetch.each do |raw|
        sanitized = sanitize(raw)

        next if Item.where(id: sanitized[:id]).any?

        Item.new(sanitized).tap do |item|
          item.watched = false
          item.save!
        end
      end
    end

    def sanitize raw
      RawSanitizer.new(raw).sanitize
    end
  end
end
