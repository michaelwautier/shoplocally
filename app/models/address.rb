class Address < ApplicationRecord
  def full_address
    "#{street} #{number}, #{postcode} #{city}"
  end
end
