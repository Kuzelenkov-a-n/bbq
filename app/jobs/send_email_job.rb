class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(event, model)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [model.user&.email]).uniq

    case model
    when Comment then all_emails.each { |email| EventMailer.comment(event, model, email).deliver_later }
    when Photo then all_emails.each { |email| EventMailer.photo(event, model, email).deliver_later }
    else EventMailer.subscription(event, model).deliver_later
    end
  end
end
