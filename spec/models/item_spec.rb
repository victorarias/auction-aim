require 'spec_helper'

describe Item do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :ends_at }
    it { should validate_presence_of :published_at }
  end

  describe "importation" do
    let(:client) do
      Auctionet::Client.new.tap do |client|
        allow(client).to receive(:perform_request).and_return File.open("spec/assets/items.json").read
      end
    end

    it "import a raw item" do
      expect do
        Item.import(client)
      end.to change(Item, :count).by 1
    end

    it "does not duplicate items" do
      expect do
        Item.import client
        Item.import client
      end.to change(Item, :count).by 1
    end

    it "imports nested bids" do
      expect do
        Item.import client
      end.to change { Bid.count }
    end
  end
end
