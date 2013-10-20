require 'spec_helper'
require 'auctionet/client'

describe Auctionet::Client do
  before(:each) do
    sample = File.read "spec/assets/items.json"
    allow(subject).to receive(:perform_request).and_return sample
  end

  it "fetch items" do
    expect(subject.fetch.size).to be > 0
  end

  it "returns an array" do
    expect(subject.fetch).to be_kind_of(Array)
  end
end
