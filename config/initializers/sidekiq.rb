# frozen_string_literal: true

# Will likely be running in a cluster on prod so only use envvar if there

if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', '127.0.0.1:6379') }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ', '127.0.0.1:6379') }
  end
end
