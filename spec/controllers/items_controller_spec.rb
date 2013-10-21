require 'spec_helper'

describe ItemsController do
  describe "GET index" do
    it "assigns @unwatched" do
      unwatched = Fabricate :item
      get :index
      expect(assigns(:unwatched)).to match_array([unwatched])
    end

    it "assigns @watched" do
      watched = Fabricate :watched_item
      get :index
      expect(assigns(:watched)).to match_array([watched])
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST watch" do
    let(:item) { Fabricate :item }

    it "watches the item" do
      post :watch, id: item.id
      item.reload
      expect(item).to be_watched
    end

    it "redirects to root" do
      post :watch, id: item.id

      expect(response).to redirect_to root_path
    end
  end

  describe "POST unwatch" do
    let(:item) { Fabricate :item }

    it "unwatches the item" do
      post :unwatch, id: item.id
      item.reload
      expect(item).to_not be_watched
    end

    it "redirects to root" do
      post :unwatch, id: item.id

      expect(response).to redirect_to root_path
    end
  end
end
