# frozen_string_literal: true

class BidAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Bid
    cannot %i[update delete], Bid
    can :create, Bid do |bid|
      bid.lot.owner.id != user.id
    end
  end
end
