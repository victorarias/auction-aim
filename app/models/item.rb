class Item < ActiveRecord::Base
  has_many :bids

  validates_presence_of :title, :ends_at, :published_at

  class << self
    def import(raw)
      raw = sanitize_raw_data raw
      find_or_create_by!(raw)
    end

    private

    def sanitize_raw_data(raw)
      raw.tap do
        [:ends_at,
         :published_at].each {|f| raw[f] = Time.at(raw[f])}
      end
    end
  end
end
