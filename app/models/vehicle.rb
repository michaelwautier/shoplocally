class Vehicle < ApplicationRecord
  TYPES = %w[bicycle car truck van]
  has_many :deliveries
end
