class OrderPolicy < ApplicationPolicy
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
