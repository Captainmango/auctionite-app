# frozen_string_literal: true

# Will likely be running in a cluster on prod so only use envvar if there

if ENV.key?('REDIS_URL_SIDEKIQ')
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ') }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch('REDIS_URL_SIDEKIQ') }
  end
end
