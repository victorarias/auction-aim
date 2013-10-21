require 'auctionet/client'

class Item < ActiveRecord::Base
  has_many :bids
  accepts_nested_attributes_for :bids

  serialize :images, Array

  validates_presence_of :title, :ends_at, :published_at

  scope :unwatched, ->{ where(watched: false).ordered }
  scope :watched,   ->{ where(watched: true).ordered  }
  scope :ordered,   ->{ order("ends_at asc") }

  def thumbs
    images.map { |hash| hash[:thumb] }
  end

  def main_thumb
    thumbs.first
  end

  def watch
    self.watched = true
  end

  def unwatch
    self.watched = false
  end

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


    def update_watched_items(client = Auctionet::Client.new)
      watched.each do |item|
        raw = client.fetch_item item.id
        sanitized = sanitize raw

        sanitized[:bids_attributes].each do |attributes|
          next if item.bids.where(external_id: attributes[:external_id]).any?

          bid = item.bids.build attributes
          bid.save!
        end
      end
    end

    private

    def sanitize raw
      RawSanitizer.new(raw).sanitize
    end
  end
end
