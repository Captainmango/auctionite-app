# frozen_string_literal: true

class BidAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Bid
    cannot :update, Bid
    cannot :delete, Bid
    cannot :create, Bid, lot: { owner: user }
  end
end
