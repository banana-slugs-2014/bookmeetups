require 'spec_helper'

describe Location do
  context "validations" do
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  context "associations" do
    it { should have_many(:users) }
  end

  context "responds to" do
    it { should respond_to(:geocheck) }
    it { should respond_to(:address) }
    it { should respond_to(:locations_within_range) }
  end


  context "instance methods" do
    let!(:test_location) { create :location }

    context '#address' do
      it "should concatinate the address" do
        expect(test_location.address).to eq([test_location.city, test_location.state, test_location.zip].compact.join(', '))
      end
    end
  end
  
end
