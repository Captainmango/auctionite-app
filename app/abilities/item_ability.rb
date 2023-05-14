# frozen_string_literal: true

class ItemAbility
  include CanCan::Ability

  def initialize(user)
    can %i[read create], Item
    can %i[update destroy], Item do |item|
      !item.lot&.live? && item.owner == user
    end
  end
end
