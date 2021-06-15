Mailjet.configure do |config|
  config.api_key = Rails.application.credentials.mailjet[:MAILJET_API_KEY]
  config.secret_key = Rails.application.credentials.mailjet[:MAILJET_SECRET_KEY]
  config.api_version = "v3.1"
end
