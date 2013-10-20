class Bid < ActiveRecord::Base
  validates_presence_of :item_id, :color, :amount, :reserve_met, :timestamp
  belongs_to :item
end
