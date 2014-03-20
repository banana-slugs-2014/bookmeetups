require 'spec_helper'

describe Location do
  context "validations" do
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  context "associations" do
    it { should have_many(:user_locations) }
    it { should have_many(:users).through(:user_locations) }
  end
end