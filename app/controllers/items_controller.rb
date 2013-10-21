class ItemsController < ApplicationController
  def index
    @unwatched  = Item.unwatched
    @watched    = Item.watched
  end

  def watch
    @item = Item.find(params[:id])
    @item.watch
    @item.save!

    redirect_to root_path
  end

  def unwatch
    @item = Item.find(params[:id])
    @item.unwatch
    @item.save!

    redirect_to root_path
  end
end
