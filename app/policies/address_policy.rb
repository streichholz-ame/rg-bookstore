class AddressPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true if user.has_role? :user
  end

  def show?
    true if user.has_role? :user
  end

  def update?
    true if user.has_role? :user
  end

  def destroy?
    true if user.has_role? :user
  end
end
