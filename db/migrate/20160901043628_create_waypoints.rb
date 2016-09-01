class CreateWaypoints < ActiveRecord::Migration
  def change
    create_table :waypoints do |t|
      t.string :elevation
      t.string :latitude
      t.string :longitude
      t.string :name
      t.string :text
      t.string :timestamp
      t.string :velocity
      t.references :most_recent_flight
      t.timestamps null: false
    end
    add_index :waypoints, :most_recent_flight_id
  end
end
