class DeliveryOption < ApplicationRecord
  validates :free_delivery_from, numericality: true
  validates :delivery_cost, numericality: true
  validates :express_delivery_cost, numericality: true

  belongs_to :shop
end
