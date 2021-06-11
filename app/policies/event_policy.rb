class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def new?
    create?
  end

  def show?
    record.user == user || record.pincode.blank?
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
