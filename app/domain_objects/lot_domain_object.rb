# frozen_string_literal: true

class LotDomainObject < ApplicationDomainObject
  attr_reader :id, :user_id, :item_id, :live_from, :live_to

  # rubocop:disable Lint/MissingSuper
  def initialize(attributes = {})
    @id = attributes['id']
    @user_id = attributes['user_id']
    @item_id = attributes['item_id']
    @live_from = attributes['live_from']
    @live_to = attributes['live_to']
  end
  # rubocop:enable Lint/MissingSuper

  def bid(amount, user_id)
    Bid.create(lot_id: id, timestamp: Time.now.utc, amount:, user_id:)
  end
end
