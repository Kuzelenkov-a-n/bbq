Recaptcha.configure do |config|
  config.site_key = Rails.application.credentials.recaptcha[:recaptcha_bbq_site_key]
  config.secret_key = Rails.application.credentials.recaptcha[:recaptcha_bbq_secret_key]
end