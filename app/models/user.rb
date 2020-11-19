class User < ApplicationRecord
  ROLES = %w[delivery owner]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :address, optional: true
  belongs_to :vehicle, optional: true
  has_many   :carts
  has_many   :deliveries
  has_one_attached :avatar

  validates :first_name, length: { minimum: 2 }, presence: true, on: [:update]
  validates :last_name, length: { minimum: 2 }, presence: true, on: [:update]
  validates :email, format: { with: /\A(\S+)@(([a-z]{3,})\.([a-z]{2,}))\z/ }

  def add_role(role)
    return unless ROLES.include?(role)

    current_roles = roles
    if current_roles
      current_roles << role unless current_roles.include?(role)
    else
      current_roles = [role]
    end
    update(roles: current_roles)
  end

  def remove_role(role)
    return unless roles

    current_roles = roles
    current_roles.delete(role)
    update(roles: current_roles)
  end
end
