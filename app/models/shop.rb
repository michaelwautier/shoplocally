require 'open-uri'
require 'json'
class Shop < ApplicationRecord
  belongs_to :address
  belongs_to :user
  has_one :deliveryOption
  has_one_attached :logo
  has_many_attached :pictures

  has_many :products


  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
  validates :description, presence: true, length: { minimum: 20 }
  validates :vat_number, format: { with: /BE\d{10}/ }
  # validates :vat_validation

  private

  def vat_validation
    vat_number = vat_number.gsub(/[ ,.-]/, '')
    response = JSON.parse(open("https://controleerbtwnummer.eu/api/validate/#{vat_number}.json").read)
    errors.add(:vat_number, "Vat number is not valid") unless response["valid"]
  end
end
