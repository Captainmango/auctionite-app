# frozen_string_literal: true

class BidController < ApplicationController
  before_action :require_login
  before_action :set_lot, only: [:place]
  rescue_from LotDomainObject::CannotPlaceBid, with: :unprocessable_entity
  rescue_from LotDomainObject::BidAmountCannotBeZero, with: :bid_cannot_be_zero

  def place
    @lot.domain_tap { |lot| lot.bid(bid_amount, current_user.id) }

    render turbo_stream: turbo_stream.replace(
      'lots_bids',
      partial: 'bid/latest_bids'
    )
  end

  private

  def set_lot
    @lot = Lot.find(params.fetch(:lot_id))
  end

  def bid_amount
    params.dig(:lot, :amount) || 0
  end

  def current_ability
    @current_ability ||= BidAbility.new(current_user)
  end

  def unprocessable_entity
    flash[:notice] = 'Cannot place bid'
    redirect_to @lot
  end

  def bid_cannot_be_zero
    flash[:notice] = 'Bid amount cannot be 0'
    redirect_to @lot
  end
end
