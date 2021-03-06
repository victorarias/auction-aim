class Item < ActiveRecord::Base
  has_many :bids
  accepts_nested_attributes_for :bids

  serialize :images, Array

  validates_presence_of :title, :ends_at, :published_at

  scope :unwatched, ->{ where(watched: false).ordered }
  scope :watched,   ->{ where(watched: true).ordered  }
  scope :ordered,   ->{ order("ends_at asc") }
  scope :current,   ->{ where("ends_at > ? OR watched = ?", Time.zone.now, true).ordered }

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

  def as_json(*params)
    super(only: [:id],
         include:  :bids )
  end
end
