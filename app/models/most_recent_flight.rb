class MostRecentFlight < ActiveRecord::Base
  belongs_to :user
  has_many :waypoints, dependent: :destroy

  def has_waypoints?
    self.waypoints.any?
  end

  def flight_length
    return 0 if waypoints.length < 2
    
    ordered_waypoints = waypoints.order(:timestamp)
    TrackLengthService.new(ordered_waypoints).calculate_length
  end

end
