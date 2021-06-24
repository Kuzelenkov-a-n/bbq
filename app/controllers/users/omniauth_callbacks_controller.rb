class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    oauth_user
  end

  def vkontakte
    oauth_user
  end

  private

  def oauth_user
    @user = User.find_for_provider_oauth(request.env["omniauth.auth"])
    provider = request.env["omniauth.auth"].provider

    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: provider)
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t("devise.omniauth_callbacks.failure",
                             kind: provider,
                             reason: I18n.t("devise.omniauth_callbacks.error"))

      redirect_to root_path
    end
  end
end
