class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
  end

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :user_email, uniqueness: { scope: :event_id }
    validate :checking_exists_email
  end

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def checking_exists_email
    if User.find_by(email: user_email).present?
      errors.add(:user_email, :already_exists)
    end
  end
end
