class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]
  after_action :verify_authorized, only: %i[create destroy]

  def create
    @new_subscription = @event.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    authorize @new_subscription

    if check_captcha(@new_subscription) && @new_subscription.save
      SendEmailJob.perform_later(@event, @new_subscription)
      redirect_to @event, notice: I18n.t("controllers.subscriptions.created")
    else
      render "events/show", alert: I18n.t("controllers.subscriptions.error")
    end
  end

  def destroy
    authorize @subscription

    @subscription.destroy

    redirect_to @event, notice: I18n.t("controllers.subscriptions.destroyed")
  end

  private

  def set_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_name, :user_email)
  end
end
