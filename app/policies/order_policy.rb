class OrderPolicy < ApplicationPolicy
  def index?
    user.has_role? :user
  end

  def show?
    user.has_role? :user
  end

  def update?
    user.has_role? :user
  end

  def destroy?
    user.has_role? :user
  end
end
