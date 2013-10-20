class Item < ActiveRecord::Base
  has_many :bids

  validates_presence_of :title, :reserve_met, :ends_at, :published_at, :watched
end
