OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.credentials[:facebook_id], Rails.application.credentials[:facebook_secret]
end
