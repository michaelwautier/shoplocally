class Productreview < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true, length: { minimum: 5 }
  validates :rating, presence: true, numericality: true, inclusion: 0..5
end
