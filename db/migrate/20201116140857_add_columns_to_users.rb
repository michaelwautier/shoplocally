class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_reference :users, :address, foreign_key: true
    add_column :users, :phone_number, :string
    add_column :users, :roles, :string
    add_reference :users, :vehicle, foreign_key: true
  end
end
