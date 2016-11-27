class MostRecentFlight < ActiveRecord::Base
  belongs_to :user
  has_many :waypoints, dependent: :destroy

  def has_waypoints?
    self.waypoints.any?
  end

  def flight_length
    puts 'HERE WE GO'
    return 0 if waypoints.length < 2
    ordered_waypoints = waypoints.order(:timestamp)
    w1 = ordered_waypoints.first
    w2 = ordered_waypoints.last
    HaversineDistanceService.new(w1,w2).calculate_distance.round(2)
  end

end
