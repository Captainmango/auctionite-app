# frozen_string_literal: true

class LotDomainObject < ApplicationDomainObject
  uses_model :lot

  def bid(amount, user_id)
    highest_bid = bids.order('amount DESC').first

    unless amount.to_f > highest_bid.amount && highest_bid.user.id != user_id
      flash.now[:notice] = 'The highest bid was placed by you or is too low to be the new highest bid.'
      return
    end

    bids.create(timestamp: Time.now.utc, amount:, user_id:)
  end
end
