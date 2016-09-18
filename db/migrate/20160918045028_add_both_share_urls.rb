class AddBothShareUrls < ActiveRecord::Migration
  def change
    rename_column :users, :share_url, :in_reach_share_url
    add_column :users, :spot_share_url, :string
  end
end
