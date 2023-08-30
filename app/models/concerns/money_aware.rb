# frozen_string_literal: true

module MoneyAware
  extend ActiveSupport::Concern

  def price_to_human(amount)
    case amount
    when Float
      (amount / 100).round(2)
    else
      (amount.to_f / 100).round(2)
    end
  rescue StandardError
    Rails.logger.warn("[MoneyAware#price_to_human] tried to convert a non number value. class: #{amount.class}")
  end

  def price_from_human(amount)
    (amount.to_f * 100).round
  rescue StandardError
    Rails.logger.warn("[MoneyAware#price_from_human] failed to convert value to integer. class: #{amount.class}")
  end
end
