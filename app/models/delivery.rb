class Delivery < ApplicationRecord
  STATUS = %w[pending delivery_pickup customer_pickup assigned in_transport undeliverable delivered]
  belongs_to :order
  belongs_to :shop
  belongs_to :user, optional: true
  belongs_to :vehicle, optional: true

  validates :shop, presence: true
  validates :order, presence: true

  geocoded_by :full_address
  after_validation :geocode

  def cart_products
    order.cart.cart_products.select { |line| line.product.shop == shop }
  end

  def full_address
    order.address.full_address
  end
end
