require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.development?
    config.storage = :fog
    config.fog_directory = 'jarrie-portfolio'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', nil),
      aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', nil),
      region: 'ap-northeast-1',
      path_style: true
    }
    config.fog_public = false
  elsif Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end
end
