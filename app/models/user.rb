class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook vkontakte]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def self.find_for_provider_oauth(access_token)
    email = access_token.info.email
    user = where(email: email).first

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id

    case provider
    when "facebook"
      url = "https://facebook.com/#{id}"
      user_name = access_token.info.name
      user_avatar = access_token.info.image.gsub(/http/, "https")
    when "vkontakte"
      url = "https://vk.com/id#{id}"
      user_name = access_token.extra.raw_info.first_name
      user_avatar = access_token.extra.raw_info.photo_400_orig
    end

    where(url: url, provider: provider).first_or_create! do |user|
      user.email = email
      user.name = user_name
      user.remote_avatar_url = user_avatar
      user.password = Devise.friendly_token.first(16)
    end
  end

  private

  def set_name
    self.name = "Товарищ №#{rand(777)}" if name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
