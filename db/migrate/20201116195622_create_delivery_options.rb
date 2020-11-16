class CreateDeliveryOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_options do |t|
      t.references :shop, null: false, foreign_key: true
      t.float :free_delivery_from
      t.float :delivery_cost
      t.float :express_delivery_cost

      t.timestamps
    end
  end
end
