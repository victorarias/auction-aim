class ItemsController < ApplicationController
  def index
    @unwatched = Item.all.to_a
    @watched = []
  end
end
