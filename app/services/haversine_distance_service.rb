class HaversineDistanceService

  def initialize(w1, w2)
    @w1 = w1
    @w2 = w2
  end

  def calculate_distance
    lat1 = @w1.latitude.to_f
    long1 = @w1.longitude.to_f
    lat2 = @w2.latitude.to_f
    long2 = @w2.longitude.to_f

    dtor = Math::PI/180
    r = 6378.14

    rlat1 = lat1 * dtor
    rlong1 = long1 * dtor
    rlat2 = lat2 * dtor
    rlong2 = long2 * dtor

    dlon = rlong1 - rlong2
    dlat = rlat1 - rlat2

    a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
    d = r * c

    return d # in kilometers
  end

  private

    def power(num, pow)
      num ** pow
    end

end
