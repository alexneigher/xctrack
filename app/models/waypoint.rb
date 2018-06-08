class Waypoint < ApplicationRecord
  belongs_to :most_recent_flight

  validates :latitude, :longitude, presence: true
end
