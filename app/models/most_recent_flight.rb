class MostRecentFlight < ActiveRecord::Base
  belongs_to :user
  has_many :waypoints, dependent: :destroy


  def has_waypoints?
    self.waypoints.any?
  end
end
