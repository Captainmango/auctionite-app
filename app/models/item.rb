# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :photos, dependent: :destroy, as: :imageable

  validates :name, :description, :starting_price, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 1}
end
