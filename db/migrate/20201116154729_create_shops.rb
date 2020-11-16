class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :description
      t.references :address, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :vat_number

      t.timestamps
    end
  end
end
