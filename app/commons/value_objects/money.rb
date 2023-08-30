# frozen_string_literal: true

module ValueObjects
  class Money
    attr_reader :value

    # @param amount [Integer] the amount in the lowest denomination (pence, cents etc)
    def initialize(value)
      @value = value
    end

    # @return [Float] the amount in a human readble way
    def amount
      raise unless @value.is_a? Numeric

      case @value
      when Float
        (@value / 100).round(2)
      else
        (@value.to_f / 100).round(2)
      end
    rescue StandardError => e
      Rails.logger.warn('[ValueObjects::Money#amount] Failed to read amount')
      raise e
    end

    # @param amount [Float] the amount in the lowest denomination (pence, cents etc)
    def self.from_human(amount)
      raise unless amount.is_a? Numeric

      new((amount.to_f * 100).round)
    rescue StandardError => e
      Rails.logger.warn("[ValueObjects::Money#from_human] failed to convert value. class: #{amount.class}")
      raise e
    end
  end

  def ==(other)
    other.value == value
  end
end
