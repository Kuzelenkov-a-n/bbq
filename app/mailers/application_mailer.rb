class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.mailjet[:MAILJET_SENDER]
  layout "mailer"
end
