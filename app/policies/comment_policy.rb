class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    can_read_event?
  end

  def destroy?
    user_can_delete?
  end
end
