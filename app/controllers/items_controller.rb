class ItemsController < ApplicationController
  def index
    @unwatched  = Item.unwatched
    @watched    = Item.watched
  end
end
