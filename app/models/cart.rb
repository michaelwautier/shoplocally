class Cart < ApplicationRecord
  belongs_to :user
  has_many   :cart_products, dependent: :destroy
  has_one    :order

  def total_price
    total = 0
    cart_products.each do |line|
      total += line.quantity * line.product_price.to_i * 100
    end
    return total
  end
end
