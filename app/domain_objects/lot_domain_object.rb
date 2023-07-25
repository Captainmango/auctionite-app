# frozen_string_literal: true

class LotDomainObject < ApplicationDomainObject
  uses_model :lot

  def bid(amount, user_id)
    # @todo add logic in here to check the bid can actually be placed (amount should always be greater than max bid)
    # if you are the highest bidder, you cannot place another bid. Only when you are not the highest bidder
    bids.create(timestamp: Time.now.utc, amount:, user_id:)
  end
end
