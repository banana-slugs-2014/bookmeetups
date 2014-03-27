require 'spec_helper'


describe LatLongLimitFinder.new( 0, 0, 1 ) do
  it { should respond_to (:lat_range_lower) }
  it { should respond_to (:long_range_lower) }
  it { should respond_to (:lat_range_upper) }
  it { should respond_to (:long_range_lower) }
end


describe LatLongLimitFinder do
  it "responds appropriately at the equator" do
    l = LatLongLimitFinder.new( 0, 0, 69.172 )
    expect( l.lat_range_upper ).to eq( 1.0 )
    expect( l.lat_range_lower ).to eq( -1.0 )
    expect( l.long_range_upper ).to eq( 1.000024238308501 )
    expect( l.long_range_lower ).to eq( -1.0 )
  end

  it "responds apporpriatly above the equator" do
    l = LatLongLimitFinder.new( 50, 50, 100 )
    expect( l.lat_range_upper ).to eq( 51.4456716590528 ) 
    expect( l.lat_range_lower ).to eq( 48.5543283409472 )
    expect( l.long_range_upper ).to eq( 50.92928235380056 )
    expect( l.long_range_lower ).to eq( 48.5543283409472 )
  end
end