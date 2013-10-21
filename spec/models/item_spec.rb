require 'spec_helper'

describe Item do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :ends_at }
    it { should validate_presence_of :published_at }
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
