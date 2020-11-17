class Cart < ApplicationRecord
  belongs_to :user
  has_many   :cart_products, dependent: :destroy
  has_one    :order
end
