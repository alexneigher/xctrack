class AddLookbackDurationToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :lookback_duration, :integer, default: 12
  end
end
