class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :address, optional: true
  belongs_to :vehicle, optional: true
  has_many   :carts

  validates :first_name, length: { minimum: 2 }, presence: true, on: [:update]
  validates :last_name, length: { minimum: 2 }, presence: true, on: [:update]
  validates :email, format: { with: /\A(\S+)@(([a-z]{3,})\.([a-z]{2,}))\z/ }
end
