module Api
  class GroupsController < ApplicationController

    def most_recent_waypoints
      @most_recent_waypoints = []
      @group = Group.find_by(params[:id])

      if params[:debug] == "true"
        users = User
      else
        users = @group.users
      end

      users.with_waypoints.each do |user|
        @most_recent_waypoints << user.waypoints.order(:created_at).last
      end

      render json: {last_known_waypoints: @most_recent_waypoints}
    end

  end
end