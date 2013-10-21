class ItemsController < ApplicationController
  def index
    @unwatched  = Item.unwatched
    @watched    = Item.watched
  end

  def watch
    change_watched_state :watch
    redirect_to root_path
  end

  def unwatch
    change_watched_state :unwatch
    redirect_to root_path
  end

  private

  def change_watched_state state
    @item = Item.find(params[:id])
    @item.public_send state
    @item.save!
  end
end
