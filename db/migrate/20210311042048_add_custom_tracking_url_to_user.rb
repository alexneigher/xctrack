class AddCustomTrackingUrlToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :custom_inreach_tracking_strategy, :boolean, default: false
  end
end
