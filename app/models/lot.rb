# frozen_string_literal: true

class Lot < ApplicationRecord
  include SoftDeletable
  include HasDomainObject

  # @!method domain_tap
  #   @yieldparam [LotDomainObject]
  #   @return [self]
  # @!method to_domain
  #   @return [LotDomainObject]
  uses_domain_object :lot_domain_object

  belongs_to :item
  belongs_to :owner, class_name: 'User', foreign_key: :user_id, inverse_of: :lots
  has_many :bids, dependent: nil

  validates :user_id, presence: true
  validates :item_id, uniqueness: { scope: %i[item_id deleted_at] }, allow_blank: true
  validates :live_from, comparison: { less_than: :live_to }, allow_blank: true

  scope :live, lambda {
    where("
    (live_from <= :t AND live_to IS NULL)
    OR (live_from <= :t AND live_to >= :t)
    AND status = 'active'", { t: Time.current })
  }

  scope :complete, lambda {
    where("live_to <= :t AND status = 'active'", { t: Time.current })
  }
  scope :owned_by_user, ->(user_id) { where('user_id = ?', user_id) }
  enum(:status, {
         active: 'active',
         terminated: 'terminated',
         completed: 'completed'
       }, default: :active)

  def live?
    if live_to && live_from
      live_from <= Time.now.utc && live_to >= Time.now.utc
    else
      live_from <= Time.now.utc
    end
  end
end
