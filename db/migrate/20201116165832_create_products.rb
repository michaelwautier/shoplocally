class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.float :price
      t.integer :stock
      t.string :ean
      t.float :tax
      t.references :shop, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
