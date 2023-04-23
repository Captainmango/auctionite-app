# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :photos, dependent: :destroy, as: :imageable
  belongs_to :user

  validates :name, :starting_price, presence: true
  validates :starting_price, numericality: { greater_than_or_equal_to: 1 }
end
