# frozen_string_literal: true

class Item < ApplicationRecord
  include HasDomainObject

  composed_of :money, class_name: 'ValueObjects::Money', mapping: %w[starting_price value]

  has_one_attached :main_image
  has_many_attached :images

  uses_domain_object :item_domain_object

  belongs_to :owner, class_name: 'User', foreign_key: :user_id, inverse_of: :items
  has_one :lot, dependent: :destroy

  validates :name, :starting_price, presence: true
  validates :starting_price, numericality: { greater_than_or_equal_to: 1 }
end
