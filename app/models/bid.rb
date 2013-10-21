class Bid < ActiveRecord::Base
  validates_presence_of :item_id, :color, :amount, :timestamp
  belongs_to :item

  def self.external_exists?(external_id)
    Bid.exists? external_id: external_id
  end
end
