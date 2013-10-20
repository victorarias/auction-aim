class Item < ActiveRecord::Base
  has_many :bids

  validates_presence_of :title, :ends_at, :published_at

  class << self
    def import(raw)
      find_or_create_by!(raw)
    end
  end
end
