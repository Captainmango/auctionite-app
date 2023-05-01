# frozen_string_literal: true

class Lot < ApplicationRecord
  include SoftDeletable

  belongs_to :item
  belongs_to :owner, class_name: 'User', foreign_key: :user_id, inverse_of: :lots

  validates :user_id, presence: true
  validates :item_id, uniqueness: { scope: %i[item_id deleted_at] }
  validates :live_from, comparison: { less_than: :live_to }, allow_blank: true

  # Lots that have a live from that is less than now and a live to that is greater than now
  scope :live, -> { where('live_from <= ?', Time.current).where('live_to >= ?', Time.current) }
  scope :for_user, ->(user_id) { where('user_id = ?', user_id) }
end
