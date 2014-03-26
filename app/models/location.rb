class Location < ActiveRecord::Base
  attr_accessible :city, :state, :zip
  validates_presence_of :city, :state, :zip

  has_many :users
  geocoded_by :address
  before_save :geocheck

  def geocheck
    geocode unless latitude && longitude
  end

  def address
    [city, state, zip].compact.join(', ')
  end

  def find_limits(miles)
    l = LatLongLimitFinder.new(latitude, longitude, miles)
    { floorlat: l.lat_range_lower, ceillat: l.lat_range_upper,
      floorlong: l.long_range_lower, ceillong: l.long_range_upper }
  end

  def locations_within_range(miles)
    limits = find_limits( miles )
    locations = Location.where("latitude >= :floorlat AND latitude <= :ceillat AND longitude >= :floorlong AND longitude <= :ceillong", limits)
    locations_within_range_circle( miles, locations)
  end

  def locations_within_range_circle(miles, locations)
    locations.select do |location| 
      LatLongDistanceFinder.new(location.latitude, location.longitude, latitude, longitude).distance_between <= miles
    end
  end

end