class Shop < ApplicationRecord
  belongs_to :address
  belongs_to :user
  belongs_to :deliveryOption

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
  validates :description, presence: true, length: { minimum: 20 }
  validates :vat_number, format: { with: /BE\d{10}/ }
end
