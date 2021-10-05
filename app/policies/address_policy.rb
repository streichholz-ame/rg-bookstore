class AddressPolicy < ApplicationPolicy
  def index?
    user.has_role? :user
  end

  def show?
    user.has_role? :user
  end

  def update?
    (user.has_role? :user) && (user.id == record.id)
  end

  def edit?
    (user.has_role? :user) && (user.id == record.id)
  end

  def destroy?
    (user.has_role? :user) && (user.id == record.id)
  end
end
