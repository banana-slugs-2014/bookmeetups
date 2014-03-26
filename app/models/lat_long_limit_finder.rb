class LatLongLimitFinder
  EARTH_RADIUS = 3963.1676
  def initialize( lat, long, distance)
    @lat = lat
    @long = long
    @lat_difference = distance / 69.172
    @long_difference = (( distance / EARTH_RADIUS ) *
                  Math.cos( lat * (Math::PI / 180 )) *
                  (180 / Math::PI )).abs
  end

  def lat_range_lower
    @lat - @lat_difference
  end

  def lat_range_upper
    @lat + @lat_difference
  end

  def long_range_lower
    @long - @lat_difference
  end

  def long_range_upper
    @long + @long_difference
  end
end