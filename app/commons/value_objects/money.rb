# frozen_string_literal: true

module ValueObjects
  class Money
    def initialize(amount)
      @amount = amount
    end

    def amount
      case @amount
      when Float
        (@amount / 100).round(2)
      else
        (@amount.to_f / 100).round(2)
      end
    rescue StandardError => e
      Rails.logger.warn("[MoneyAware#price_to_human] tried to convert a non number value. class: #{@amount.class}")
      raise e
    end

    def self.from_human(number)
      case number
      when String then raise
      else
        new((number.to_f * 100).round)
      end
    rescue StandardError => e
      Rails.logger.warn("[MoneyAware#price_from_human] failed to convert value to integer. class: #{number.class}")
      raise e
    end
  end
end
