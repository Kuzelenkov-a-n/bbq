class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.mailjet[:MAILJET_SENDER_2]
  layout 'mailer'
end
