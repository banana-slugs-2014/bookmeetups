class Location < ActiveRecord::Base

  attr_accessible :city, :state, :zip
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  has_many :users
  geocoded_by :address
  before_save :geocode


  def address
    [city, state, zip].compact.join(', ')
  end

<<<<<<< HEAD
  def self.find_limits(lat, long, miles)
    fla, cla =LatLongDistanceConverter.lat_range(lat, miles)
    flo, clo =LatLongDistanceConverter.long_range(lat, long, miles)
    { floorlat: fla, ceillat: cla,
      floorlong: flo, ceillong: clo}
  end

  def self.locations_within_range(lat, long, miles)
    limits = Location.find_limits(lat, long, miles)
    locations = self.where("latitude >= :floorlat AND latitude <= :ceillat AND longitude >= :floorlong AND longitude <= :ceillong", limits)
    Location.locations_within_range_circle(lat, long, miles, locations)
  end

  def self.locations_within_range_circle(lat, long, miles, locations)
    in_range = []
    locations.each do |location|
      d = LatLongDistanceConverter.distance_between_two_points(location.latitude, lat, location.longitude, long)
      in_range << location if d <= miles
    end
    in_range
  end

  def in_range( miles )
    Location.locations_within_range( latitude, longitude, miles )
  end


end