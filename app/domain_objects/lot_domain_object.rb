# frozen_string_literal: true

class LotDomainObject < ApplicationDomainObject
  uses_model :lot

  def bid(amount, user_id)
    bids.create(timestamp: Time.now.utc, amount:, user_id:)
  end
end
