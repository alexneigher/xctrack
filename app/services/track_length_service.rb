require 'enumerator'
class TrackLengthService
  def initialize(track)
    @track = track.sort_by(&:timestamp)
  end

  def total_distance
    length = 0
    @track.each_cons(2) do |p1, p2|
      length += HaversineDistanceService.new(p1, p2).calculate_distance
    end
    length.round(2)
  end

  def straight_line_distance
    return 0 if @track.length < 2
    length = HaversineDistanceService.new(@track.first, @track.last).calculate_distance
    length.round(2)
  end
end
