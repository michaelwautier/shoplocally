class Address < ApplicationRecord
  geocoded_by :full_address
  after_validation :geocode

  validates :street, presence: true

  def full_address
    "#{street} #{number}, #{postcode} #{city}"
  end
end
