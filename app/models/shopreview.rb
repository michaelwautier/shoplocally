class Shopreview < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  validates :content, presence: true
  validates :rating, presence: true
end
