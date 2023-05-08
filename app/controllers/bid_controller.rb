# frozen_string_literal: true

class BidController < ApplicationController
  before_action :set_lot, only: [:place]

  def place
    @lot.domain_tap { |lot| lot.bid(bid_params['amount'], current_user.id) }
  end

  private

  def set_lot
    @lot = Lot.find(params.fetch(:lot_id))
  end

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
