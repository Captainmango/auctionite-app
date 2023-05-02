# frozen_string_literal: true

module MoneyAware
  extend ActiveSupport::Concern

  def price_to_human(number)
    case number
    when Float
      (number / 100).round(2)
    else
      (number.to_f / 100).round(2)
    end
  rescue StandardError
    Rails.logger.warn("[MoneyAware#price_to_human] tried to convert a non number value. class: #{number.class}")
  end

  def price_from_human(number)
    (number.to_f * 100).round
  rescue StandardError
    Rails.logger.warn("[MoneyAware#price_from_human] failed to convert value to integer. class: #{number.class}")
  end
end
