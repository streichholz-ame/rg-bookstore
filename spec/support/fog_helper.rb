Fog.mock!
Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')
connection = Fog::Storage.new(
  provider: 'AWS',
  aws_access_key_id: Rails.application.credentials[:S3_KEY],
  aws_secret_access_key: Rails.application.credentials[:S3_SECRET]
)
connection.directories.create(key: 'dev-bucket')
