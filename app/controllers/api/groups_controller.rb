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
        @most_recent_waypoints << user.waypoints.order(:created_at).last.attributes.merge({pilot_id: user.id, map_link: "https://www.xctrack.me/?pilots=#{user.id}"})
      end


      render json: {last_known_waypoints: @most_recent_waypoints}
    end

    def all_sar_trackpoints
      @most_recent_waypoints = []
      @group = Group.find(params[:group_id])
      users = @group.users

      users.all.each do |user|
        user.most_recent_flight&.destroy
        user.reload
        hour = (DateTime.now.to_time - DateTime.parse('22nd Aug 2020 10:05:06+07:00').to_time) / 1.hours
        response = HTTParty.get(user.full_api_url(hour)).body
        raw_xml = Nokogiri::XML(response)

        CoordinateFetcherService.new(raw_xml, user).extract_coordinates
      end

      users.reload.each do |user|
        @most_recent_waypoints << user.waypoints.order(:created_at)
      end

      render json: {data: @most_recent_waypoints.flatten}
    end

  end
end