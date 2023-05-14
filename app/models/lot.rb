# frozen_string_literal: true

class Lot < ApplicationRecord
  include SoftDeletable
  include HasDomainObject

  uses_domain_object :lot_domain_object

  belongs_to :item
  belongs_to :owner, class_name: 'User', foreign_key: :user_id, inverse_of: :lots
  has_many :bids, dependent: nil

  validates :user_id, presence: true
  validates :item_id, uniqueness: { scope: %i[item_id deleted_at] }, allow_blank: true
  validates :live_from, comparison: { less_than: :live_to }, allow_blank: true

  # Lots that have a live from that is less than now and a live to that is greater than now
  scope :live, -> { where('live_from <= :t OR (live_from <= :t AND live_to >= :t)', { t: Time.current }) }
  scope :owned_by_user, ->(user_id) { where('user_id = ?', user_id) }
end
