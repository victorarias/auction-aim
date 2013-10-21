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

end
