class ChangeTimestampFormat < ActiveRecord::Migration
  def change
    remove_column :waypoints, :timestamp
    add_column :waypoints, :timestamp, :datetime
  end
end
