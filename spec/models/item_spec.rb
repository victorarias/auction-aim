require 'spec_helper'

describe Item do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :ends_at }
    it { should validate_presence_of :published_at }
  end

  describe "importation" do
    let(:raw) do
      {
        id: 1,
        title: "title",
        reserve_met: false,
        ends_at: 1382283120,
        published_at: 1381414365,
        watched: false,
        bids: [
          {
            external_id: 2,
            color: "#2CC97A",
            amount: 1000,
            reserve_met: true,
            timestamp: 1382282910
          },
          {
            external_id: 1,
            color: "#2CC97A",
            amount: 800,
            reserve_met: true,
            timestamp: 1382282910
          }
        ]
      }
    end

    it "import a raw item" do
      expect do
        Item.import raw
      end.to change(Item, :count).by 1
    end

    it "does not duplicate items" do
      expect do
        Item.import raw
        Item.import raw
      end.to change(Item, :count).by 1
    end

    it "imports nested bids" do
      item = Item.import raw
      expect(item.bids.size).to be 2
    end
  end
end
