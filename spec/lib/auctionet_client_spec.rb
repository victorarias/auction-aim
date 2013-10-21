require 'spec_helper'
require 'auctionet/client'

describe Auctionet::Client do
  subject(:client) { Auctionet::Client.new }

  describe "#fetch" do
    before(:each) do
      sample = File.read "spec/assets/items.json"
      allow(client).to receive(:perform_request).and_return sample
    end

    it "fetch items" do
      expect(client.fetch.size).to be > 0
    end

    it "returns an array" do
      expect(client.fetch).to be_kind_of(Array)
    end
  end

  describe "#fetch_item" do
    before(:each) do
      sample = File.read "spec/assets/item.json"
      allow(client).to receive(:perform_request).with(1).and_return sample
    end

    it "fetch a single item" do
      expect(client.fetch_item(1)).to_not be_nil
    end

    it "returns the right item" do
      item = client.fetch_item(1)
      expect(item["id"]).to be 100529
    end
  end
end
