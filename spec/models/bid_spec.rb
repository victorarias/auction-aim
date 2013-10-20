require 'spec_helper'

describe Bid do
  describe "validations" do
    it { should validate_presence_of :item }
    it { should validate_presence_of :color }
    it { should validate_presence_of :amount }
    it { should validate_presence_of :reserve_met }
    it { should validate_presence_of :timestamp }
  end
end
