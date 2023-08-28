# frozen_string_literal: true

class BidController < ApplicationController
  before_action :require_login
  before_action :set_lot, only: [:place]
  # rescue_from LotDomainObject::CannotPlaceBid, with: :unprocessable_entity

  def place
    # @param lot [LotDomainObject]
    @lot.domain_tap { |lot| lot.bid(bid_amount, current_user.id) }
  rescue LotDomainObject::CannotPlaceBid
    flash[:notice] = 'Cannot place bid'
    redirect_to @lot
  rescue LotDomainObject::BidAmountCannotBeZero
    flash[:notice] = 'Bid amount cannot be 0'
    redirect_to @lot
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
  end
end
