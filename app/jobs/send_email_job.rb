class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(event, model)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [model.user&.email]).uniq

    all_emails.each do |mail|
      EventMailer.comment(event, model, mail).deliver_later if model.class == Comment
      EventMailer.photo(event, model, mail).deliver_later if model.class == Photo
    end

    EventMailer.subscription(event, model).deliver_later if model.class == Subscription
  end
end
