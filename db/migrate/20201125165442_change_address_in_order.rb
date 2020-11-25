class ChangeAddressInOrder < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :address_id, :bigint, null: true
  end
end
