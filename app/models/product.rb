class Product < ApplicationRecord
  TAXES = [6, 12, 21]
  monetize :price_cents

  belongs_to :shop
  belongs_to :category
  has_many :cart_products
  has_many :productreviews
  has_many_attached :photos

  validates :name, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :price, presence: true, numericality: { only_float: true, greater_than: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal: 0 }
  validates :ean, length: { in: (8..13) }
  validates :tax, presence: true, numericality: { only_float: true, greater_than: 0 }
  validates :category, presence: true

  def self.import(file, shop)
    CSV.foreach(file.path, headers: true) do |row|
      product_hash = Product.new
      product_hash.name = row[0]
      product_hash.description = row[1]
      product_hash.price = row[2]
      product_hash.tax = row[3]
      product_hash.stock = row[4]
      product_hash.category = Category.find_by(name: row[5])
      product_hash.ean = row[6]
      product_hash.shop = shop
      product_hash.save!
    end
  end
end
