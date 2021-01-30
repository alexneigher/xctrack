class CreateTurnpoints < ActiveRecord::Migration[5.0]
  def change
    create_table :turnpoints do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :radius
      t.integer :sort_order
      t.string :name
      t.references :group, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
