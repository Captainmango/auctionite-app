# frozen_string_literal: true

class Lot < ApplicationRecord
  include SoftDeletable

  belongs_to :item
  belongs_to :owner, class_name: 'User', foreign_key: :user_id, inverse_of: :lots

  validates :user_id, presence: true
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :item_id, uniqueness: { scope: :item_id }
  # rubocop:enable Rails/UniqueValidationWithoutIndex
  validates :live_from, comparison: { greater_than: :live_to }, allow_blank: true

  # Lots that have a live from that is less than now and a live to that is greater than now
  scope :live, -> { where('live_from <= ?', Time.current).where('live_to >= ?', Time.current) }
  scope :for_user, ->(user_id) { where('user_id = ?', user_id) }
end
