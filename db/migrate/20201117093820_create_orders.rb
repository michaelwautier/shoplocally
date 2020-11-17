class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.string :description
      t.references :cart, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true #Its for the delivery_guy
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
