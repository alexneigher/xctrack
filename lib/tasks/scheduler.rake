require 'airbrake'

Airbrake.configure do |c|
  c.project_id = 149815
  c.project_key = '12f6d0fb8f7bd060abc3679f8618af45'
end


desc "This task is called by the Heroku scheduler add-on"
task :fetch_user_waypoints => :environment do

  User.all.each do |user|
    puts "Starting fetch_user_waypoints for user: #{user.id}"
    user.fetch_coordinates
    puts "done fetch_user_waypoints for user: #{user.id}"
  end

end
