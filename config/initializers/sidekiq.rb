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

Sidekiq.configure_server do |config|
  config.on(:startup) do
    schedule_file = 'config/schedule.yml'

    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file)
  end
end
