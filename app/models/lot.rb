# frozen_string_literal: true

class Lot < ApplicationRecord
  include SoftDeletable

  belongs_to :item
  delegate :owner, to: :item, allow_nil: false

  validates :item_id, uniqueness: { scope: :item_id }

  # Lots that have a live from that is less than now and a live to that is greater than now
  scope :live, -> { where('live_from <= ?', Time.current).where('live_to >= ?', Time.current) }
end
