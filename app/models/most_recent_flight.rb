class MostRecentFlight < ApplicationRecord
  belongs_to :user
  has_many :waypoints, dependent: :destroy

  def has_waypoints?
    self.waypoints.any?
  end

  def flight_length
    return 0 if waypoints.length < 2
    TrackLengthService.new(waypoints).total_distance
  end

  def straight_line_distance
    return 0 if waypoints.length < 2
    TrackLengthService.new(waypoints).straight_line_distance
  end
end
