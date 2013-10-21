require 'spec_helper'

describe ItemsController do
  describe "GET index" do
    it "assigns @unwatched" do
      get :index
      expect(assigns(:unwatched)).to be_kind_of(Array)
    end

    it "assigns @watched" do
      get :index
      expect(assigns(:watched)).to be_kind_of(Array)
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template :index
    end
  end

end
