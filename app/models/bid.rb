class Bid < ActiveRecord::Base
  validates_presence_of :item_id, :color, :amount, :timestamp
  belongs_to :item
end
