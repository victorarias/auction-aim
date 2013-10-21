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

    it "import nested bids" do
      expect do
        Item.import client
      end.to change { Bid.count }
    end

    it "import images" do
      Item.import client
      first = Item.first
      expect(first.images).to_not be_empty
    end
  end

  describe "update of watched items" do
    let(:client) do
      Auctionet::Client.new.tap do |client|
        allow(client).to receive(:perform_request).and_return File.open("spec/assets/item.json").read
      end
    end

    let!(:item) { Fabricate :watched_item, id: 100529 };

    it "updates watched items" do
      expect do
        Item.update_watched_items(client)
      end.to change { item.reload; item.bids.count }.by 1
    end

    it "does not duplicate items" do
      Item.update_watched_items(client)
      expect do
        Item.update_watched_items(client)
      end.to_not change { item.reload; item.bids.count }
    end
  end

  describe "images" do
    subject do
      Fabricate.build :item, images: [
        { thumb: "path1", hd: "path_hd1" },
        { thumb: "path2", hd: "path_hd2" }
      ]
    end

    it "filter thumbs" do
      expect(subject.thumbs).to match_array(["path1", "path2"])
    end

    it "has a main thumbnail" do
      expect(subject.main_thumb).to eq "path1"
    end
  end

  describe "#watch" do
    it "makes it watched" do
      expect do
        subject.watch
      end.to change { subject.watched }.to true
    end
  end

  describe "#unwatch" do
    it "makes it unwatched" do
      expect do
        subject.unwatch
      end.to change { subject.watched }.to false
    end
  end
end
