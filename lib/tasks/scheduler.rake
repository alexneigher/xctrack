desc "This task is called by the Heroku scheduler add-on"
task :fetch_user_waypoints => :environment do

  User.tracking_enabled.each do |user|
    puts "Starting fetch_user_waypoints for user: #{user.id}"
    begin
      user.fetch_coordinates
    rescue => e
      next
    end
    puts "done fetch_user_waypoints for user: #{user.id}"
  end

end



desc "Populate new trackpoints.json file hourly"
task :populate_sar_file => :environment do
  @most_recent_waypoints = []
  @group = Group.find(153)

  users = @group.users

  users.all.each do |user|
    user.most_recent_flight&.destroy
    user.reload

    hour = (DateTime.now.to_time - DateTime.parse('22nd Aug 2020 10:05:06+07:00').to_time) / 1.hours

    response = HTTParty.get( user.full_api_url(hour) ).body
    raw_xml = Nokogiri::XML(response)
    CoordinateFetcherService.new(raw_xml, user).extract_coordinates

  end

  users.with_waypoints.each do |user|
    @most_recent_waypoints << user.waypoints.order(:created_at)
  end

  points = @most_recent_waypoints.flatten.to_json

  file = File.open("public/trackpoints.json", "w")
  file.puts(points)
  file.close

end