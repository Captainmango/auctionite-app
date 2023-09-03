# frozen_string_literal: true

class Bid < ApplicationRecord
  composed_of :money, class_name: 'ValueObjects::Money', mapping: %w[amount value]
  belongs_to :user
  belongs_to :lot

  validates :user_id, :lot_id, :amount, presence: true
  validates :amount, numericality: { only_integer: true }
end
