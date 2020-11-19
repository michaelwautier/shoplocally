class ChangeUserRolesColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :roles
    add_column :users, :roles, :string, array: true, null: true
  end
end
