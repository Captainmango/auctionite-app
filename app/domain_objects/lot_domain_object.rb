# frozen_string_literal: true

class LotDomainObject < ApplicationDomainObject
  CannotPlaceBid = Class.new(StandardError)
  uses_model :lot

  def bid(amount, user_id)
    highest_bid = bids.order('amount DESC').first

    raise CannotPlaceBid if highest_bid && !bid_can_be_placed?(amount, highest_bid, user_id)

    bids.create(timestamp: Time.now.utc, amount:, user_id:)
  end

  private

  def bid_can_be_placed?(amount, bid, user_id)
    amount.to_f > bid&.amount.to_f && bid.user&.id != user_id
  end
end
