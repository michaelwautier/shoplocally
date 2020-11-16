class ChangeColumnNameInVehicle < ActiveRecord::Migration[6.0]
  def change
    rename_column :vehicles, :type, :type_name
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
