class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
    validate :user_not_event_author
  end

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :user_email, uniqueness: { scope: :event_id }
    validate :email_not_taken
  end


  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def email_not_taken
    errors.add(:user_email, :already_exists) if User.exists?(email: user_email)
  end

  def user_not_event_author
    errors.add(:user_name, :self_event) if user == event.user
  end
end
