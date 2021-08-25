CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials[:S3_KEY],
    aws_secret_access_key: Rails.application.credentials[:S3_SECRET]
  }
  config.storage = :fog
  config.fog_public = false
  config.fog_directory = Rails.application.credentials[:S3_BUCKET]
end
