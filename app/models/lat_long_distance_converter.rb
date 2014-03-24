=begin comment
1.  Hate this module pattern style stuff
2.  so much easier to pass the core variables in during .new()
3.  See 1.
=end

class LatLongDistanceConverter
  def self.lat_to_miles( degrees_lat )
    degrees_lat * 69.172
  end

  def self.long_to_miles( degrees_long, latitude )
    0.01745329251994 * degrees_long * Math.cos( latitude )
  end

  def self.distance_between_two_points(lat_a, lat_b, lon_a, lon_b)
    dlon = (lon_a - lon_b) * Math::PI / 180 
    dlat = (lat_a - lat_b) * Math::PI / 180
    lat_a *= Math::PI / 180 
    lat_b *= Math::PI / 180 
    a = Math.sin( dlat / 2 ) ** 2 + Math.cos( lat_a ) * Math.cos( lat_b ) *
    ( Math.sin( dlon / 2 ) ) ** 2
    c = 2 * Math.atan2( Math.sqrt( a ),  Math.sqrt( 1 - a ) )
    3963.1676 * c
  end

  def self.lat_range( lat, distance )
    x = distance / 69.172
    [ lat - x, lat + x ]
  end

  def self.long_range( lat, long, distance )
    x =(( distance / 3963.1676 ) *
    Math.cos( lat * (Math::PI / 180 )) * (180 / Math::PI )).abs
    [ long - x , long + x ]
  end
end
