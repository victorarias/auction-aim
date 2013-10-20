class Bid < ActiveRecord::Base
  validates_presence_of :item, :color, :amount, :reserve_met, :timestamp
  belongs_to :item
end
