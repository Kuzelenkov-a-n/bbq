class ApplicationPolicy
  attr_reader :context, :record, :cookies, :user

  delegate :cookies, to: :context
  delegate :user, to: :context

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  def initialize(context, record)
    @context = context
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  private

  def can_read_event?
    event = record.event

    return true if event.user == user
    return false if event.pincode.present? && !event.pincode_valid?(cookies["events_#{event.id}_pincode"])

    true
  end

  def user_can_delete?
    return true if record.event.user == user
    return true if record.user == user && user.present?

    false
  end
end
