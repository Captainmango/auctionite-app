module MoneyAware
  extend ActiveSupport::Concern

  def price_to_human(number)
    case number
    when Integer
      (number.to_f / 100).round(2)
    when Float
      (number / 100).round(2)
    end
  end

  def price_from_human(number)
    (number.to_f * 100).round
  end
end
