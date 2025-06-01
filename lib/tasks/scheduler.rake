desc "Fetch the first group of Users tracking"
task :fetch_user_waypoints => :environment do

  users = User.tracking_enabled.where("id % 4 = ?", 0)
  users.find_each(batch_size: 100) do |user|

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

desc "Fetch the second group of Users tracking"
task :fetch_user_waypoints_1 => :environment do

  users = User.tracking_enabled.where("id % 4 = ?", 1)
  users.find_each(batch_size: 100) do |user|

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

desc "Fetch the third group of Users tracking"
task :fetch_user_waypoints_2 => :environment do

  users = User.tracking_enabled.where("id % 4 = ?", 2)
  users.find_each(batch_size: 100) do |user|

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

desc "Fetch the fourth group of Users tracking"
task :fetch_user_waypoints_3 => :environment do

  users = User.tracking_enabled.where("id % 4 = ?", 3)
  users.find_each(batch_size: 100) do |user|

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
