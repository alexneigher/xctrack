class AddTrackerTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :tracker_type, :integer, default: 0
  end
end
