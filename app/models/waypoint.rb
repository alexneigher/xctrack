class Waypoint < ActiveRecord::Base
  belongs_to :most_recent_flight

  validates :latitude, :longitude, presence: true
end
