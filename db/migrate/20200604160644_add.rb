class Add < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :accepted_terms_and_privacy, :boolean, default: false
  end
end
