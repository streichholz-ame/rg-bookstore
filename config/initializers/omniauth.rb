OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.credentials.facebook[:id], Rails.application.credentials.facebook[:secret]
end
