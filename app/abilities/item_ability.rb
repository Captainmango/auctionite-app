# frozen_string_literal: true

class ItemAbility
  include CanCan::Ability

  def initialize(user)
    can :create, Item
    can :read, Item, owner: user
    can %i[update destroy], Item do |item|
      !item.lot&.live? && item.owner == user
    end
  end
end
