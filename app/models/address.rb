class Address < ApplicationRecord
  geocoded_by :full_address
  after_validation :geocode

  validates :street, presence: true, length: { minimum: 2 }
  validates :number, presence: true, length: { minimum: 1 }
  validates :postcode, presence: true, length: { minimum: 4, maximum: 7 }
  validates :city, presence: true, length: { minimum: 2 }

  def full_address
    "#{street} #{number}, #{postcode} #{city}"
  end
end
