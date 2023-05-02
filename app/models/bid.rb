# frozen_string_literal: true

class Bid < ApplicationRecord
  inlcude MoneyAware

  belongs_to :user
  belongs_to :lot

  validates :user_id, :lot_id, :amount, presense: true
  validates :amount, numericality: { only_integer: true }

  def amount
    price_to_human(self[:amount]) || self[:amount]
  end

  def amount=(price)
    self[:amount] = price_from_human(price)
  end
end
