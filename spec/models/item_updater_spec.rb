require 'spec_helper'

describe ItemUpdater do
  let(:client) do
    Auctionet::Client.new.tap do |client|
      allow(client).to receive(:perform_request).and_return File.open("spec/assets/item.json").read
    end
  end
  subject(:updater) { ItemUpdater.new(client) }
  let!(:item) { Fabricate :watched_item, id: 100529 };

  context "updating" do
    before(:each) do
      allow(MessageBus).to receive :publish
    end

    it "updates watched items" do
      expect do
        updater.run
      end.to change { item.reload; item.bids.count }.by 1
    end

    it "does not duplicates bids" do
      updater.run
      expect do
        updater.run
      end.to_not change { item.reload; item.bids.count }
    end
  end

  it "notifies updates" do
    expect(MessageBus).to receive(:publish)
    updater.run
  end
end
