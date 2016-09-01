desc "This task is called by the Heroku scheduler add-on, every 15 minutes"
task :fetch_user_waypoints => :environment do
  puts "Starting fetch_user_waypoints"

  User.all.map(&:fetch_coordinates)

  puts "done fetch_user_waypoints"
end
