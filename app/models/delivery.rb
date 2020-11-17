class Delivery < ApplicationRecord
  belongs_to :order
  belongs_to :shop
  belongs_to :user
  belongs_to :vehicle
end
