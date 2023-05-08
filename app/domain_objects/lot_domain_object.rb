# frozen_string_literal: true

class LotDomainObject < ApplicationDomainObject
  uses_model :lot

  def bid(amount, user_id)
    lot_model.find(id).bids.create(timestamp: Time.now.utc, amount:, user_id:)
  end
end
