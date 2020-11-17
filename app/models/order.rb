class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user
  belongs_to :address, optional: true
  has_many   :deliveries
end
