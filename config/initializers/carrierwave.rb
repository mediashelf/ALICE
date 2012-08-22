require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.permissions = 0666
  # config.directory_permissions = 0777
  config.storage = :file
  # config.fog_credentials = {
    # provider: 'AWS',
    # aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    # aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  # }

  # config.fog_directory = ENV['AWS_DIRECTORY']
  # config.fog_host = ENV['AWS_HOST']
end
