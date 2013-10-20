require 'spec_helper'


describe Item do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :reserve_met }
    it { should validate_presence_of :ends_at }
    it { should validate_presence_of :published_at }
    it { should validate_presence_of :watched }
  end
end
