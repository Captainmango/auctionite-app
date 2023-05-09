# frozen_string_literal: true

class Item < ApplicationRecord
  include MoneyAware

  has_many_attached :images

  belongs_to :owner, class_name: 'User', foreign_key: :user_id, inverse_of: :items
  has_one :lot, dependent: :destroy

  validates :name, :starting_price, presence: true
  validates :starting_price, numericality: { greater_than_or_equal_to: 1 }

  def starting_price
    price_to_human(self[:starting_price])
  end

  def starting_price=(price)
    self[:starting_price] = price_from_human(price)
  end
end
