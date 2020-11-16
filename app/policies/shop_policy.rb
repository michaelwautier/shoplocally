class ShopPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    record.user == user
  end

  def destroy?
    false
    # TODO: only site admin
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
