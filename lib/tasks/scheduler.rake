desc "This task is called by the Heroku scheduler add-on"
task :fetch_user_waypoints => :environment do

  User.tracking_enabled.find_each(batch: 100) do |user|

    puts "Starting fetch_user_waypoints for user: #{user.id}"
    begin
      user.fetch_coordinates
    rescue => e
      puts "Error fetching coordiantes for #{user.id}: #{e}"
      next
    end
    puts "done fetch_user_waypoints for user: #{user.id}"
  end

end
