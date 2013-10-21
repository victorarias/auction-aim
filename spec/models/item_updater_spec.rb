require 'spec_helper'

describe ItemUpdater do
  let(:client) do
    Auctionet::Client.new.tap do |client|
      allow(client).to receive(:perform_request).and_return File.open("spec/assets/item.json").read
    end
  end
  subject { ItemUpdater.new(client) }
  let!(:item) { Fabricate :watched_item, id: 100529 };

  it "updates watched items" do
    expect do
      subject.run
    end.to change { item.reload; item.bids.count }.by 1
  end

  it "does not duplicate items" do
    subject.run
    expect do
      subject.run
    end.to_not change { item.reload; item.bids.count }
  end
end
