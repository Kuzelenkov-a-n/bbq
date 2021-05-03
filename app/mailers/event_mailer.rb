class EventMailer < ApplicationMailer
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: I18n.t('event_mailer.subscription.subject', event_title: event.title)
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    mail to: email, subject: I18n.t('event_mailer.comment.subject', event_title: event.title)
  end

  def photo(event, photo, email)
    @photo = photo
    @event = event

    mail to: email, subject: I18n.t('event_mailer.photo.subject', event_photo: photo.photo.url)
  end
end
