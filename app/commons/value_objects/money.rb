# frozen_string_literal: true

module ValueObjects
  class Money
    def initialize(amount)
      @amount = amount
    end

    def amount
      raise unless @amount.is_a? Numeric

      case @amount
      when Float
        (@amount / 100).round(2)
      else
        (@amount.to_f / 100).round(2)
      end
    rescue StandardError => e
      Rails.logger.warn('[ValueObjects::Money#amount] Failed to read amount')
      raise e
    end

    def self.from_human(number)
      raise unless number.is_a? Numeric

      new((number.to_f * 100).round)
    rescue StandardError => e
      Rails.logger.warn("[ValueObjects::Money#from_human] failed to convert value. class: #{number.class}")
      raise e
    end
  end
end
