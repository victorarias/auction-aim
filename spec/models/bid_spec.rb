require 'spec_helper'

describe Bid do
  describe "validations" do
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :color }
    it { should validate_presence_of :amount }
    it { should validate_presence_of :timestamp }
  end

  describe "#exists" do
    context "when the bid exists" do
      it "returns true" do
        Fabricate :bid, external_id: 1
        expect(Bid.external_exists? 1).to be_true
      end
    end
    context "when the bid does not exists" do
      it "returns false" do
        expect(Bid.external_exists? 1).to be_false
      end
    end
  end
end
