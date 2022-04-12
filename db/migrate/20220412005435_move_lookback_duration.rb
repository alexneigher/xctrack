class MoveLookbackDuration < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :lookback_duration

    add_column :users,  :lookback_duration, :integer, default: 12
  end
end
