class AddTrackingEnabledToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tracking_enabled, :boolean, default: true
  end
end
