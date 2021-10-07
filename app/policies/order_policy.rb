class OrderPolicy < ApplicationPolicy
  def index?
    logged_in_user?
  end

  def show?
    logged_in_user?
  end

  def update?
    logged_in_user?
  end

  def destroy?
    logged_in_user?
  end
end
