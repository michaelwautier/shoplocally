class Delivery < ApplicationRecord
  belongs_to :order
  belongs_to :shop
  belongs_to :user, optional: true
  belongs_to :vehicle, optional: true

  def cart_products
    cart_product = order.cart.cart_products
    cart_products = cart_product.select { |line| line.product.shop == shop }
  end
end
