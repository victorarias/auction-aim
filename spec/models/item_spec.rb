require 'spec_helper'

describe Item do
  subject(:item) { Item.new }
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :ends_at }
    it { should validate_presence_of :published_at }
  end

  describe "images" do
    subject(:item) do
      Fabricate.build :item, images: [
        { thumb: "path1", hd: "path_hd1" },
        { thumb: "path2", hd: "path_hd2" }
      ]
    end

    it "filter thumbs" do
      expect(item.thumbs).to match_array(["path1", "path2"])
    end

    it "has a main thumbnail" do
      expect(item.main_thumb).to eq "path1"
    end
  end

  describe "#current" do
    it "returns current items" do
      item = Fabricate :item
      expect(Item.current.to_a).to match_array([item])
    end

    it "does not return old items" do
      item = Fabricate :item, ends_at: 2.days.ago
      expect(Item.current.to_a).to be_empty
    end

    it "returns watched old items" do
      item = Fabricate :watched_item, ends_at: 2.days.ago
      expect(Item.current.to_a).to match_array([item])
    end
  end

  describe "#watch" do
    it "makes it watched" do
      expect do
        item.watch
      end.to change { item.watched }.to true
    end
  end

  describe "#unwatch" do
    it "makes it unwatched" do
      expect do
        item.unwatch
      end.to change { item.watched }.to false
    end
  end
end
