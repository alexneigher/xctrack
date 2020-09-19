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
