OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.credentials[:APP_ID], Rails.application.credentials[:APP_SECRET]
end
