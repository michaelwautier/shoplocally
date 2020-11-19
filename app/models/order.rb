class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user, optional: true  # only if delivery guy has been assigned
  belongs_to :address, optional: true
  has_many   :deliveries

  validates :cart, presence: true
  validates :user, presence: true
end
