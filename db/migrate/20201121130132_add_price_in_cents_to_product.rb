class AddPriceInCentsToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :price_in_cents, :integer
  end
end
