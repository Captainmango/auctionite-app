# frozen_string_literal: true

module LotsHelper
  def owned_by_current_user(lot)
    lot.owner == current_user
  end

  def new_lot?(lot)
    lot.item_id.nil?
  end
end
