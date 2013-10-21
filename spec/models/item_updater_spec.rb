require 'spec_helper'

describe ItemUpdater do
  let(:client) do
    Auctionet::Client.new.tap do |client|
      allow(client).to receive(:perform_request).and_return File.open("spec/assets/item.json").read
    end
  end
  subject { ItemUpdater.new(client) }
  let!(:item) { Fabricate :watched_item, id: 100529 };

  context "updating" do
    before(:each) do
      allow(MessageBus).to receive :publish
    end

    it "updates watched items" do
      expect do
        subject.run
      end.to change { item.reload; item.bids.count }.by 1
    end

    it "does not duplicates bids" do
      subject.run
      expect do
        subject.run
      end.to_not change { item.reload; item.bids.count }
    end
  end

  it "notifies updates" do
    expect(MessageBus).to receive(:publish)
    subject.run
  end
end
