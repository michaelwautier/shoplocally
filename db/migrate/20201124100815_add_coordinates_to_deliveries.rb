class AddCoordinatesToDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :latitude, :float
    add_column :deliveries, :longitude, :float
  end
end
