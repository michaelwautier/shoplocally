class Product < ApplicationRecord
  TAXES = [6, 12, 21]
  belongs_to :shop
  belongs_to :category
  has_many :cart_products
  has_many_attached :photos

  validates :name, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :price, presence: true, numericality: { only_float: true, greater_than: 0 }
  validates :stock, presence: true, numericality: true
  validates :ean, length: { in: (8..13) }
  validates :tax, presence: true, numericality: { only_float: true, greater_than: 0 }
  validates :category, presence: true
end
