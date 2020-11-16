class ShopPolicy < ApplicationPolicy
  class Scope < Scope
    def update?
      record.user == user
    end

    def destroy?
      false
      # TODO: only site admin
    end

    def resolve
      scope.all
    end
  end
end
