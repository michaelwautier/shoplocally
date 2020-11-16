class Category < ApplicationRecord
  has_many :products

  CATEGORIES = ["food", "electronics", "clothes", "toys & games", "sport", "home"]
end
