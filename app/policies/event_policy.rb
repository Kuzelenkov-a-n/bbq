class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def show?
    return true if event_owner?
    return true if record.pincode.blank?
    return true if record.pincode_valid?(cookies["events_#{record.id}_pincode"])

    false
  end

  def edit?
    event_owner?
  end

  def update?
    event_owner?
  end

  def destroy?
    event_owner?
  end

  private

  def event_owner?
    record.user == user
  end
end
