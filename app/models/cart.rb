class Cart < ApplicationRecord
  belongs_to :user
  has_many   :cart_products
  has_one    :order
end
