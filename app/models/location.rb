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

  def self.locations_within_range(lat, long, miles)
    fla, cla =LatLongDistanceConverter.lat_range(lat, miles) 
    flo, clo =LatLongDistanceConverter.long_range(lat, long, miles) 
    limits = {
      floorlat: fla,
      ceillat: cla,
      floorlong: flo,
      ceillong: clo
    }
    floorlat, ceillat = LatLongDistanceConverter.lat_range(lat, miles)
    floorlong, ceillong = LatLongDistanceConverter.long_range(lat, long, miles) 
    self.where("latitude >= :floorlat AND latitude <= :ceillat AND longitude >= :floorlong AND longitude <= :ceillong",
      limits)
  end

  def in_range( miles )
    Location.locations_within_range( latitude, longitude, miles )
  end

end