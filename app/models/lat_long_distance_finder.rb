class LatLongDistanceFinder
  EARTH_RADIUS = 3963.1676
  def initialize(lat_first, long_first, lat_second, long_second)
    @lat_first = lat_first
    @long_first = long_first
    @lat_second = lat_second
    @long_second = long_second
  end

  def distance_between
    diff_lat = to_rad( @lat_first - @lat_second )
    diff_long = to_rad( @long_first - @long_second ) 
    a = Math.sin( diff_lat / 2 ) * Math.sin( diff_lat / 2 ) + 
        Math.cos( to_rad( @lat_first)  ) * Math.cos( to_rad( @lat_second ) ) *
        Math.sin( diff_long / 2 ) *  Math.sin( diff_long / 2 )
    c = 2 * Math.atan2( Math.sqrt( a ),  Math.sqrt( 1 - a ) )
    EARTH_RADIUS * c
  end

  def to_rad(num)
    num * (Math::PI / 180)
  end
end