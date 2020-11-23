class AddSessionIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :checkout_session_id, :string, null: true
  end
end
