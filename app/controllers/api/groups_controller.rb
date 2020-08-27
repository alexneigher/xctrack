module Api
  class GroupsController < ApplicationController
    layout false

    def most_recent_waypoints
      @most_recent_waypoints = []
      @group = Group.find_by(params[:id])

      if params[:debug] == "true"
        users = User
      else
        users = @group.users
      end

      users.with_waypoints.each do |user|
        @most_recent_waypoints << user.waypoints.order(:created_at).last.attributes.merge({pilot_id: user.id, map_link: "https://www.xctrack.me/?pilots=#{user.id}"})
      end


      render json: {last_known_waypoints: @most_recent_waypoints}
    end

    def sar_json
      render file: 'public/trackpoints.json'
    end

  end
end