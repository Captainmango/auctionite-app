# frozen_string_literal: true

class BidController < ApplicationController
  before_action set_lot only: [:place]

  def place
    @lot.bids.create
  end

  private

  def set_lot
    @lot = Lot.find(params.fetch(:lot_id))
  end
end
