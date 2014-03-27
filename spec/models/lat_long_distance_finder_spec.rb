require 'spec_helper'

describe LatLongDistanceFinder do
  context "#to_rad" do
    it "converts a number to radians" do
      lld = LatLongDistanceFinder.new(5,5,5,5)
      expect { lld.to_rad(5) }.to be{ 5 * (Math::PI / 180) }
    end
  end

  context "#distance_between" do
    it "returns the apropriate distance between two points" do
      lld = LatLongDistanceFinder.new(1,2,3,5)
      expect { lld.distance_between }.to be{ 249.28316251819894 }
    end
  end
end