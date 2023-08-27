# frozen_string_literal: true

class LotAbility
  include CanCan::Ability

  def initialize(user)
    can %i[read create], Lot
    can %i[update destroy], Lot do |lot|
      lot.owner.id == user.id && !lot.live?
    end
  end
end
