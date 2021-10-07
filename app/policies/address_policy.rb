class AddressPolicy < ApplicationPolicy
  def index?
    logged_in_user?
  end

  def show?
    logged_in_user?
  end

  def update?
    recorded_user?
  end

  def edit?
    recorded_user?
  end

  def destroy?
    recorded_user?
  end
end
