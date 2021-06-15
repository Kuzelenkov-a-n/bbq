Recaptcha.configure do |config|
  config.site_key = Rails.application.credentials.recaptcha[:recaptcha_bbq_public_key]
  config.secret_key = Rails.application.credentials.recaptcha[:recaptcha_bbq_private_key]
end