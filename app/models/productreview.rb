class Productreview < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true
  validates :rating, presence: true
end
