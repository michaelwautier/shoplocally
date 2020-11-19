class ChangeUserInDeliveries < ActiveRecord::Migration[6.0]
  def change
    change_column :deliveries, :user_id, :bigint, null: true
  end
end
