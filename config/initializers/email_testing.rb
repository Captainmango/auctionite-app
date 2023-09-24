# frozen_string_literal: true

class SandboxEmailInterceptor
  def self.delivering_email(message)
    message.to = ['auctionite.app@gmail.com']
  end
end

Rails.application.configure do
  if Rails.env.development?
    config.action_mailer.interceptors = %w[SandboxEmailInterceptor]
  end
end
