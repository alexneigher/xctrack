class AddColorToTurnpoint < ActiveRecord::Migration[5.0]
  def change
    add_column :turnpoints, :color, :string
  end
end
