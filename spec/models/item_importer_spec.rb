require 'spec_helper'

describe ItemImporter do
  let(:client) do
    Auctionet::Client.new.tap do |client|
      allow(client).to receive(:perform_request).and_return File.open("spec/assets/items.json").read
    end
  end
  subject(:importer) { ItemImporter.new(client) }

  it "import a raw item" do
    expect do
      importer.run
    end.to change(Item, :count).by 1
  end

  it "does not duplicate items" do
    expect do
      importer.run
      importer.run
    end.to change(Item, :count).by 1
  end

  it "import nested bids" do
    expect do
      importer.run
    end.to change { Bid.count }
  end

  it "import images" do
    importer.run
    first = Item.first
    expect(first.images).to_not be_empty
  end
end
