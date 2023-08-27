# frozen_string_literal: true

class BidController < ApplicationController
  before_action :require_login
  before_action :set_lot, only: [:place]
  rescue_from LotDomainObject::CannotPlaceBid, with: :unprocessable_entity

  def place
    @lot.domain_tap { |lot| lot.bid(bid_amount, current_user.id) }
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
