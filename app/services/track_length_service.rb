require 'enumerator'
class TrackLengthService

  def initialize(track)
    @track = track
  end

  def calculate_length
    length = 0
    @track.each_cons(2) { |p1, p2|
        length += HaversineDistanceService.new(p1,p2).calculate_distance
    }
    length.round(2)
  end
end
