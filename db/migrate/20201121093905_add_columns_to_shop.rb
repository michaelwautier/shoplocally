class AddColumnsToShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :longitude, :float
    add_column :shops, :latitude, :float
  end
end
