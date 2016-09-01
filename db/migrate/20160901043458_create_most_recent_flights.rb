class CreateMostRecentFlights < ActiveRecord::Migration
  def change
    create_table :most_recent_flights do |t|
      t.integer :timeframe
      t.references :user
      t.timestamps null: false
    end
  end
end
