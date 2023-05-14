# frozen_string_literal: true

class LotAbility
  include CanCan::Ability

  def initialize(user)
    can :read, Lot
    can %i[update destroy], Lot, owner: user
  end
end